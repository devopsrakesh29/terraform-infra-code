variable "kvs" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku_name                        = string
    enabled_for_disk_encryption     = optional(bool) # true
    soft_delete_retention_days      = optional(number)
    purge_protection_enabled        = optional(bool)
    enabled_for_deployment          = optional(bool) # bool optional true
    enabled_for_template_deployment = optional(bool) # bool optional true
    rbac_authorization_enabled      = optional(bool) # optional bool false
    public_network_access_enabled   = optional(bool) # optional bool default true
    tags                            = optional(map(string))

    network_acls = optional(map(object({
      bypass                     = string
      default_action             = string
      ip_rules                   = optional(string)
      virtual_network_subnet_ids = optional(list(string))

    })))
  }))
}
