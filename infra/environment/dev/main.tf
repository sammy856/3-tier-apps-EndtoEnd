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
  service_endpoints    = each.value.service_endpoints
}

module "vms" {
  source              = "../../module/lvm"
  for_each            = var.vmdetails
  location            = module.rgs[each.value.rgkey].location
  resource_group_name = module.rgs[each.value.rgkey].rgnames
  subnet_id           = module.subnets[each.value.subnetkey].subnet_ids
  lvm_name            = each.value.lvmname
  vm_size             = each.value.vmsize
  admin_username      = each.value.adminusername
  admin_password      = each.value.adminpassword
}

module "passwords" {
  source = "../../module/random"
}

module "sqlservers" {
  source                       = "../../module/sqlserver"
  for_each                     = var.sqldetails
  sqlservername                = each.value.sqlservername
  resource_group_name          = module.rgs[each.value.rgkey].rgnames
  location                     = module.rgs[each.value.rgkey].location
  administrator_login          = each.value.administratorlogin
  administrator_login_password = module.passwords.sqlpasswords
}

module "kvs" {
  source              = "../../module/keyvault"
  for_each            = var.kvdetails
  keyvaultname        = each.value.keyvaultname
  resource_group_name = module.rgs[each.value.rgkey].rgnames
  location            = module.rgs[each.value.rgkey].location
  tenant_id           = data.azurerm_client_config.current.tenant_id
  object_id           = data.azurerm_client_config.current.object_id
  sqlusername         = each.value.sqlusername
  sqlusernamevalue    = module.sqlservers[each.value.sql_key].sqlusernames
  sqlpassword         = each.value.sqlpassword
  sqlpasswordvalue    = module.passwords.sqlpasswords
}
