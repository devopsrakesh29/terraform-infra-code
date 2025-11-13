variable "vmss" {
  type = map(object({
    subnet_name         = string
    vnet_name           = string
    resource_group_name = string
    vmss_name           = string
    location            = string
    sku                 = string
    instances           = number
    admin_username      = string
    admin_password      = string
    admin_ssh_key = optional(map(object({
      username   = string
      public_key = string
    })))
    source_image_reference = object({
      publisher = string
      offer     = string
      sku       = string
      version   = string
    })
    os_disk = object({
      storage_account_type = string
      caching              = string
    })
    network_interfaces = map(object({
      name    = string
      primary = bool
      ip_configuration = map(object({
        name    = string
        primary = bool
      }))
    }))
  }))

}
