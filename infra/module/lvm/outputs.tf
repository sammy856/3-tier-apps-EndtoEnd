output "public_ip" {
  value = try(azurerm_public_ip.pip[0].ip_address, "")
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.lvm.id
}

output "vm_name" {
  value = azurerm_linux_virtual_machine.lvm.name
}

output "nic_id" {
  value = azurerm_network_interface.nic.id
}
