
variable "vms" {
  type = map(object({
    vm_name = string
    subnet_name = string
    vnet_name = string
    pip_name = string
    nic_name                        = string
    key_vault_name = string
    username = string
    password = string
    resource_group_name             = string
    size                            = string # "Standard_F2"
    location                        = string
    disable_password_authentication = optional(bool) #  optional false 
    tags                            = optional(map(string))
    custom_data                     = optional(string)
    auxiliary_mode                 = optional(string)
    auxiliary_sku                  = optional(string)
    dns_servers                    = optional(list(string))
    edge_zone                      = optional(string)
    ip_forwarding_enabled          = optional(bool)
    accelerated_networking_enabled = optional(bool)
    internal_dns_name_label        = optional(string)

    ip_configurations = map(object({
      name                                               = string #"internal"
      private_ip_address_allocation                      = string # "Dynamic"
      gateway_load_balancer_frontend_ip_configuration_id = optional(string)
      primary                                            = optional(bool)
    }))
    admin_ssh_keys = optional(map(object({
      username   = string
      public_key = string
    })))
    os_disks = map(object({
      caching              = string
      storage_account_type = string
    }))
    source_image_references = map(object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }))
  }))
}


