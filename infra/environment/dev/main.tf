module "rgs" {

  source   = "../../module/rg"
  for_each = var.rgdetails
  rgname   = each.value.rgname
  location = each.value.location
}


module "vnets" {
  source        = "../../module/vnet"
  for_each      = var.vnetdetails
  vnetname      = each.value.vnetname
  rgname        = module.rgs[each.value.rgkey].rgnames
  location      = module.rgs[each.value.rgkey].location
  address_space = each.value.address_space
}


module "subnets" {
  source               = "../../module/subnet"
  for_each             = var.subnetdetails
  subnet_name          = each.value.subnetname
  resource_group_name  = module.rgs[each.value.rgkey].rgnames
  virtual_network_name = module.vnets[each.value.vnetkey].vnetnames
  address_prefixes     = each.value.address_prefixes
}

module "vms" {
  source                     = "../../module/lvm"
  for_each                   = var.vmdetails
  location                   = module.rgs[each.value.rgkey].location
  resource_group_name        = module.rgs[each.value.rgkey].rgnames
  subnet_id                  = module.subnets[each.value.subnetkey].subnet_ids
  lvm_name                   = each.value.lvmname
  vm_size                    = each.value.vmsize
  admin_username             = each.value.adminusername
  admin_password             = each.value.adminpassword
  user_assigned_identity_ids = try(each.value.identitykey != null ? [module.identities[each.value.identitykey].identity_ids] : [], [])
  ssh_public_key            = lookup(each.value, "ssh_public_key", file("../../ssh/deploy_key.pub"))
  create_public_ip          = lookup(each.value, "create_public_ip", false)
}

module "passwords" {
  source = "../../module/random"
}

module "identities" {
  source              = "../../module/identity"
  for_each            = var.identitydetails
  name                = each.value.identityname
  location            = module.rgs[each.value.rgkey].location
  resource_group_name = module.rgs[each.value.rgkey].rgnames
}

module "sqlservers" {
  depends_on                   = [module.rgs, module.passwords, module.vnets, module.subnets]
  source                       = "../../module/sqlserver"
  for_each                     = var.sqldetails
  sqlservername                = each.value.sqlservername
  resource_group_name          = module.rgs[each.value.rgkey].rgnames
  location                     = module.rgs[each.value.rgkey].location
  administrator_login          = each.value.administratorlogin
  administrator_login_password = module.passwords.sqlpasswords
}

module "kvs" {
  depends_on             = [module.sqlservers, module.passwords, module.identities]
  source                 = "../../module/keyvault"
  for_each               = var.kvdetails
  keyvaultname           = each.value.keyvaultname
  resource_group_name    = module.rgs[each.value.rgkey].rgnames
  location               = module.rgs[each.value.rgkey].location
  tenant_id              = data.azurerm_client_config.current.tenant_id
  object_id              = module.identities[each.value.identitykey].principal_ids
  additional_object_ids  = [data.azurerm_client_config.current.object_id]
}

module "kv_secrets" {
  depends_on   = [module.kvs, module.sqlservers]
  source       = "../../module/keyvault_secrets"
  for_each     = var.kvsecretdetails
  keyvault_id  = module.kvs[each.value.kvkey].keyvault_ids
  secret_name  = each.value.secretname
  secret_value = module.passwords.sqlpasswords
}


module "kv_private_endpoints" {
  depends_on = [module.kvs, module.subnets, module.vnets]
  source     = "../../module/private_endpoint"
  for_each   = var.kvdetails

  name                           = "pe-${each.value.keyvaultname}"
  location                       = module.rgs[each.value.rgkey].location
  resource_group_name            = module.rgs[each.value.rgkey].rgnames
  subnet_id                      = module.subnets[each.value.subnetkey].subnet_ids
  virtual_network_id             = module.vnets[var.subnetdetails[each.value.subnetkey].vnetkey].vnet_ids
  private_connection_resource_id = module.kvs[each.key].keyvault_ids
  subresource_names              = ["vault"]
  private_dns_zone_name          = "privatelink.vaultcore.azure.net"
}

module "sql_private_endpoints" {
  depends_on = [module.sqlservers, module.subnets, module.vnets]
  source     = "../../module/private_endpoint"
  for_each   = var.sqldetails

  name                           = "pe-${each.value.sqlservername}"
  location                       = module.rgs[each.value.rgkey].location
  resource_group_name            = module.rgs[each.value.rgkey].rgnames
  subnet_id                      = module.subnets[each.value.subnetkey].subnet_ids
  virtual_network_id             = module.vnets[var.subnetdetails[each.value.subnetkey].vnetkey].vnet_ids
  private_connection_resource_id = module.sqlservers[each.key].mssql_server_ids
  subresource_names              = ["sqlServer"]
  private_dns_zone_name          = "privatelink.database.windows.net"
}


module "kv_rbac" {
  source   = "../../module/rbac"
  for_each = var.kvdetails

  scope                = module.kvs[each.key].keyvault_ids
  principal_id         = module.identities[each.value.identitykey].principal_ids
  role_definition_name = "Key Vault Secrets User"

  depends_on = [module.kvs, module.identities]
}

module "sql_rbac" {
  source   = "../../module/rbac"
  for_each = var.sqldetails

  scope                = module.sqlservers[each.key].mssql_server_ids
  principal_id         = module.identities[each.value.identitykey].principal_ids
  role_definition_name = "SQL DB Contributor"

  depends_on = [module.sqlservers, module.identities]
}
