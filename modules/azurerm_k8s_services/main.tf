#--- ACR 
resource "azurerm_container_registry" "acr" {
  for_each = var.kubernetes_clusters
  name                = each.value.acr_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  sku                 = each.value.sku #"Premium"
}


#---AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  for_each            = var.kubernetes_clusters
  name                = each.value.aks_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  dns_prefix          = each.value.dns_prefix # Optional
  tags                = each.value.tags       # Optional

  dynamic "default_node_pool" {

    for_each = each.value.default_node_pool
    content {
      name       = default_node_pool.value.name
      node_count = default_node_pool.value.node_count # number 
      vm_size    = default_node_pool.value.vm_size    # "Standard_D2_v2"
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? each.value.identity : {}

    content {
      type = identity.value.type # "SystemAssigned"
    }
  }
}

#----Attaching a Container Registry to a Kubernetes Cluster
resource "azurerm_role_assignment" "ars" {
  for_each = var.kubernetes_clusters
  principal_id                     = azurerm_kubernetes_cluster.aks[each.key].kubelet_identity[0].object_id
  role_definition_name             = each.value.role_definition_name #"AcrPull"
  scope                            = azurerm_container_registry.acr[each.key].id
  skip_service_principal_aad_check = each.value.skip_service_principal_aad_check # true
}