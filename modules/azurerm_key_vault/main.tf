
resource "azurerm_key_vault" "kv" {
  for_each                        = var.kvs
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption # bool true
  tenant_id                       = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days      = each.value.soft_delete_retention_days      #number 30
  purge_protection_enabled        = each.value.purge_protection_enabled        # bool false
  enabled_for_deployment          = each.value.enabled_for_deployment          # bool optional true
  enabled_for_template_deployment = each.value.enabled_for_template_deployment # bool optional true
  rbac_authorization_enabled      = each.value.rbac_authorization_enabled      # optional bool false
  public_network_access_enabled   = each.value.public_network_access_enabled   # optional bool default true
  tags                            = each.value.tags


  sku_name = each.value.sku_name # string "standard"

  dynamic "network_acls" {
    for_each = each.value.network_acls != null ? each.value.network_acls : {}
    content {
      bypass                     = network_acls.value.bypass
      default_action             = network_acls.value.default_action
      ip_rules                   = network_acls.value.ip_rules # optional 
      virtual_network_subnet_ids = network_acls.value.virtual_network_subnet_ids # optional
    }
  }


  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List"
    ]

    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover",
      "Restore"
    ]

    storage_permissions = [
      "Get",
      "List"
    ]

    certificate_permissions = [
      "Get",
      "List"
    ]
  }
}


