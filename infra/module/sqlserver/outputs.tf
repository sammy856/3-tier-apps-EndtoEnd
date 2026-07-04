output "sqlusernames" {
  value = azurerm_mssql_server.mssql_server.administrator_login
}

output "sqlpasswords" {
  value = azurerm_mssql_server.mssql_server.administrator_login_password
}

output "mssql_server_ids" {
  value = azurerm_mssql_server.mssql_server.id
}