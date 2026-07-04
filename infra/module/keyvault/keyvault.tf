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
    tenant_id = var.tenant_id
    object_id = var.object_id

    key_permissions = [
      "Get",
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
    ]

    storage_permissions = [
      "Get",
    ]
  }

  dynamic "access_policy" {
    for_each = var.additional_object_ids
    content {
      tenant_id = var.tenant_id
      object_id = access_policy.value

      key_permissions = [
        "Get",
      ]

      secret_permissions = [
        "Get",
        "List",
        "Set",
      ]

      storage_permissions = [
        "Get",
      ]
    }
  }
}


output "keyvault_ids" {
  value = azurerm_key_vault.key_vault.id
}