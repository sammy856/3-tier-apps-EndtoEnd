output "identity_ids" {
  value = azurerm_user_assigned_identity.uai.id
}

output "principal_ids" {
  value = azurerm_user_assigned_identity.uai.principal_id
}

output "client_ids" {
  value = azurerm_user_assigned_identity.uai.client_id
}
