
resource "azurerm_mssql_server" "sql_server" {
  for_each                     = var.databases
  name                         = each.value.dbserver_name
  resource_group_name          = each.value.resource_group_name
  location                     = each.value.location
  version                      = each.value.version 
  administrator_login          = data.azurerm_key_vault_secret.username[each.key].value
  administrator_login_password = data.azurerm_key_vault_secret.password[each.key].value
  tags = each.value.tags
}

resource "azurerm_mssql_database" "sql_db" {
    for_each = var.databases
  name         = each.value.sql_database_name
  server_id    = azurerm_mssql_server.sql_server[each.key].id
  collation    = each.value.collation #"SQL_Latin1_General_CP1_CI_AS"
  license_type = each.value.license_type # "LicenseIncluded"
  max_size_gb  = each.value.max_size_gb #2
  sku_name     = each.value.sku_name #"S0"
  enclave_type = each.value.enclave_type #"VBS"
}
