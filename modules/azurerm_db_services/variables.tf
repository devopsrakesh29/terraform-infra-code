variable "databases" {
  type = map(object({
    dbserver_name       = string
    resource_group_name = string
    location            = string
    version             = string
    tags                = optional(map(string))
    sql_database_name   = string
    key_vault_name      = string
    username            = string
    password            = string
    collation           = optional(string)
    license_type        = optional(string)
    max_size_gb         = optional(string)
    sku_name            = optional(string)
    enclave_type        = optional(string)

  }))
}
