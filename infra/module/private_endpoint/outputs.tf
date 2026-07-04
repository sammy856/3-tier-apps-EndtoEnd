output "private_endpoint_id" {
  value = azurerm_private_endpoint.pe.id
}

output "private_dns_zone_name" {
  value = azurerm_private_dns_zone.pdz.name
}
