resource "azurerm_key_vault_secret" "kv_secret" {
  for_each     = var.kv_secrets
  name         = each.value.key_vault_secret_name
  value        = each.value.key_vault_secret_value
  key_vault_id = data.azurerm_key_vault.kv[each.key].id
}

