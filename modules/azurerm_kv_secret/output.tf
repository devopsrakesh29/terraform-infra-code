# output "key_vault_secret_value" {
#   description = "The value of the Key Vault Secret."
#    value = { for k, v in azurerm_key_vault_secret.kv_secret : k => v.value }
#   sensitive   = true # Mark as sensitive to prevent showing in plain text in console/logs
# }



