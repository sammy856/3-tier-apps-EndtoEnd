resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = var.location
  resource_group_name = var.rgname
  address_space       = var.address_space
}
