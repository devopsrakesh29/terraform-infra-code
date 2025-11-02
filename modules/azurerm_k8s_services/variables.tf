variable "kubernetes_clusters" {
  type = map(object({
    acr_name = string
    sku = string
    
    aks_name                = string
    location            = string
    resource_group_name = string
    dns_prefix          = optional(string)
    tags                = optional(map(string))
    role_definition_name = string
    skip_service_principal_aad_check = bool
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
