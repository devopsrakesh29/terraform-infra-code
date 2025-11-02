variable "kv_secrets" {
    type = map(object({
  key_vault_secret_name         = string
  key_vault_secret_value        = string
  key_vault_name = string
  resource_group_name = string
    }))
}

