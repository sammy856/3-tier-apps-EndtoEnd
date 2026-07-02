resource "azurerm_mssql_server" "mssql_server" {
  name                         = var.sqlservername
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}

resource "azurerm_mssql_database" "mssql_database" {
  name         = "${var.sqlservername}-db"
  server_id    = azurerm_mssql_server.mssql_server.id
  collation    = "SQL_Latin1_General_CP1_CI_AS"
  license_type = "LicenseIncluded"
  max_size_gb  = 2
  sku_name     = "S0"
  enclave_type = "VBS"
}
