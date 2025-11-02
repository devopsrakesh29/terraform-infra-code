resource "azurerm_storage_account" "storage_account" {
  name                     = var.storage_account_name
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  min_tls_version          = var.min_tls_version
  access_tier              = var.access_tier
  public_network_access_enabled = var.public_network_access_enabled
  tags                     = var.tags


}



