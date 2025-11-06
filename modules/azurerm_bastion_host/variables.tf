variable "bastion_hosts" {
  type = map(object({

    subnet_name         = string
    vnet_name           = string
    resource_group_name = string
    pip_name            = string
    bastion_name        = string
    location            = string
    ip_configurations = map(object({
      name = string

    }))
  }))
}
