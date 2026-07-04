resource "random_uuid" "this" {}

resource "azurerm_role_assignment" "this" {
  name                 = random_uuid.this.result
  scope                = var.scope
  role_definition_name = var.role_definition_name
  principal_id         = var.principal_id
}
