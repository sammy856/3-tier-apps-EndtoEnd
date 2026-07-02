resource "azurerm_key_vault" "key_vault" {
  name                        = var.keyvaultname
  location                    = var.location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = var.tenant_id #data.azurerm_client_config.current.tenant_id
    object_id = var.object_id #data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}

resource "azurerm_key_vault_secret" "kv_sqlusername" {
  name         = var.sqlusername
  value        = var.sqlusernamevalue
  key_vault_id = azurerm_key_vault.key_vault.id
}


resource "azurerm_key_vault_secret" "kv_sqlpassword" {
  name         = var.sqlpassword
  value        = var.sqlpasswordvalue
  key_vault_id = azurerm_key_vault.key_vault.id
}
