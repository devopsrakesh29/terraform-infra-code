# # RG variables

variable "resource_groups" {
  type = map(object({
    name     = string
    location = string
    tags     = map(string)

  }))

 }

# # storage account variables
# variable "storage_accounts" {
#   type = map(object({
#     stg_name                      = string
#     account_tier                  = string
#     account_replication_type      = string
#     min_tls_version               = optional(string, "TLS1_2")
#     access_tier                   = optional(string, "Hot")
#     https_traffic_only            = optional(bool, true)
#     public_network_access_enabled = optional(bool, true)
#     tags                          = optional(map(string))

#   }))
# }

# ################################################

# # variable "aks_subscription_id" {
# #   type = string
# # }

# # subscription_id variables
variable "storage_account_subscription_id" {
  type = string

}

variable "vnet_subscription_id" {
  type = string

}

variable "rg_subscription_id" {
  type = string

}

# ################################################
# # vnet variable
# variable "virtual_networks" {
#   type = map(object({
#     name                           = string
#     location                       = string
#     resource_group_name            = string
#     address_space                  = optional(list(string))
#     dns_servers                    = optional(list(string))
#     tags                           = optional(map(string))
#     edge_zone                      = optional(string)
#     flow_timeout_in_minutes        = optional(string)
#     private_endpoint_vnet_policies = optional(string)

#     ddos_protection_plans = optional(object({
#       enable = bool
#       id     = string
#     }))

#     encryptions = optional(object({
#       enforcement = string
#     }))

#     subnets = optional(map(object({
#       name                              = string
#       address_prefixes                  = list(string)
#       security_group                    = optional(string)
#       default_outbound_access_enabled   = optional(bool)
#       private_endpoint_network_policies = optional(string)

#     })))

#     ip_address_pools = optional(list(object({
#       id                     = string
#       number_of_ip_addresses = number
#     })))


#   }))
# }

# ############################################
# # NSG variables

# variable "nsgs" {
#   type = map(object({

#     name                = string
#     location            = string
#     resource_group_name = string
#     tags                = map(string)
#     security_rules = optional(map(object({
#       name                       = string
#       priority                   = number
#       direction                  = string
#       access                     = string
#       protocol                   = string
#       source_port_range          = optional(string)
#       destination_port_range     = optional(string)
#       source_address_prefix      = optional(string)
#       destination_address_prefix = optional(string)

#     })))

#   }))
# }

# ########################################################
# # key vault variables

# variable "kvs" {
#   type = map(object({
#     name                            = string
#     location                        = string
#     resource_group_name             = string
#     enabled_for_disk_encryption     = optional(bool) # true
#     soft_delete_retention_days      = optional(number)
#     purge_protection_enabled        = optional(bool)
#     enabled_for_deployment          = optional(bool) # bool optional true
#     enabled_for_template_deployment = optional(bool) # bool optional true
#     rbac_authorization_enabled      = optional(bool) # optional bool false
#     public_network_access_enabled   = optional(bool) # optional bool default true
#     tags                            = optional(map(string))
#     sku_name                        = string

#     network_acls = optional(map(object({
#       bypass                     = string
#       default_action             = string
#       ip_rules                   = optional(string)
#       virtual_network_subnet_ids = optional(list(string))

#     })))
#   }))
# }

# ########################################################

# variable "kv_secrets" {
#   type = map(object({
#     key_vault_secret_name  = string
#     key_vault_secret_value = string
#     key_vault_name         = string
#     resource_group_name    = string
#   }))
# }

# variable "resource_group_name" {
#   type = string

# }
# ##############################################
# variable "pips" {
#   type = map(object({
#     name                = string
#     resource_group_name = string
#     location            = string
#     allocation_method   = string
#     tags                = optional(map(string))
#   }))
# }

# ################################################

# variable "nic_name" {
#   type = string
# }

# variable "nsg_name" {
#   type = string
# }

# ################################################



# variable "vms" {
#   type = map(object({
#     vm_name                         = string
#     subnet_name                     = string
#     vnet_name                       = string
#     pip_name                        = string
#     nic_name                        = string
#     key_vault_name                  = string
#     username                        = string
#     password                        = string
#     resource_group_name             = string
#     size                            = string # "Standard_F2"
#     location                        = string
#     disable_password_authentication = optional(bool) #  optional false 
#     tags                            = optional(map(string))
#     custom_data                     = optional(string)
#     auxiliary_mode                  = optional(string)
#     auxiliary_sku                   = optional(string)
#     dns_servers                     = optional(list(string))
#     edge_zone                       = optional(string)
#     ip_forwarding_enabled           = optional(bool)
#     accelerated_networking_enabled  = optional(bool)
#     internal_dns_name_label         = optional(string)

#     ip_configurations = map(object({
#       name                                               = string #"internal"
#       private_ip_address_allocation                      = string # "Dynamic"
#       gateway_load_balancer_frontend_ip_configuration_id = optional(string)
#       primary                                            = optional(bool)
#     }))
#     admin_ssh_keys = optional(map(object({
#       username   = string
#       public_key = string
#     })))
#     os_disks = map(object({
#       caching              = string
#       storage_account_type = string
#     }))
#     source_image_references = map(object({
#       publisher = string
#       offer     = string
#       sku       = string
#       version   = string
#     }))
#   }))
# }



########################
variable "kubernetes_clusters" {
  type = map(object({
    acr_name = string
    sku      = string

    aks_name                         = string
    location                         = string
    resource_group_name              = string
    dns_prefix                       = optional(string)
    tags                             = optional(map(string))
    role_definition_name             = string
    skip_service_principal_aad_check = bool
    ingress_application_gateway = optional(map(object({
      gateway_name   = optional(string)
    })))    

    default_node_pool = map(object({
      name       = string
      node_count = number
      vm_size    = string
    }))
    identity = optional(map(object({
      type = string
    })))
  }))
}

#####################################

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
############################################

# variable "bastion_hosts" {
#   type = map(object({

#     subnet_name         = string
#     vnet_name           = string
#     resource_group_name = string
#     pip_name            = string
#     bastion_name        = string
#     location            = string
#     ip_configurations = map(object({
#       name = string

#     }))
#   }))
# }
