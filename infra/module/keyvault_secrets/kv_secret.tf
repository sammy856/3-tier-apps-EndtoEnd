resource "azurerm_key_vault_secret" "kv_sqlusername" {
  name         = var.secret_name
  value        = var.secret_value
  key_vault_id = var.keyvault_id
}

variable "secret_name" {

}

variable "secret_value" {

}


variable "keyvault_id" {

}