module "rgs" {

  source = "../../modules/resource_group"

  for_each = var.rgdetails

  rgname = each.value.rgname

  location = each.value.location

}


module "vnets" {

  source = "../../modules/virtual_network"

  for_each = var.vnetdetails

  vnetname = each.value.vnetname

  rgname = module.rgs[each.value.rgkey].name

  location = module.rgs[each.value.rgkey].location

  address_space = each.value.address_space

  dns_servers = each.value.dns_servers

  tags = each.value.tags

}


module "subnets" {

  source = "../../modules/subnet"

  for_each = var.subnetdetails

  subnet_name = each.value.subnetname

  resource_group_name = module.rgs[each.value.rgkey].name

  virtual_network_name = module.vnets[each.value.vnetkey].name

  address_prefixes = each.value.address_prefixes

  service_endpoints = each.value.service_endpoints
}

module "nics" {

  source = "../../module/nic"

  for_each = var.nicdetails

  nic_name = each.value.nic_name

  location = module.rgs[each.value.rgkey].location

  resource_group_name = module.rgs[each.value.rgkey].name

  subnet_id = module.subnets[each.value.subnetkey].id

  ip_configuration_name = each.value.ip_configuration_name

  private_ip_allocation = each.value.private_ip_allocation

  private_ip = each.value.private_ip

  public_ip_id = module.publicips[each.value.pipkey].id

  tags = each.value.tags

}