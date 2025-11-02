variable "virtual_networks" {
  type = map(object({
    name                           = string
    location                       = string
    resource_group_name            = string
    address_space                  = optional(list(string))
    dns_servers                    = optional(list(string))
    tags                           = optional(map(string))
    edge_zone                      = optional(string)
    flow_timeout_in_minutes        = optional(string)
    private_endpoint_vnet_policies = optional(string)

    ddos_protection_plans = optional(object({
      enable = bool
      id     = string
    }))

    encryptions = optional(object({
      enforcement = string
    }))

    subnets = optional(list(object({
      name                              = string
      address_prefixes                  = list(string)
      security_group                    = optional(string)
      default_outbound_access_enabled   = optional(bool)
      private_endpoint_network_policies = optional(string)

    })))

    ip_address_pools = optional(list(object({
      id                     = string
      number_of_ip_addresses = number 
    })))


  }))
}

