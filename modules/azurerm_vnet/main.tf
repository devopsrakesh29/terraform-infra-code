resource "azurerm_virtual_network" "vnet" {
  for_each = var.virtual_networks

  name                           = each.value.name
  location                       = each.value.location
  resource_group_name            = each.value.resource_group_name
  address_space                  = each.value.address_space                  # optional
  dns_servers                    = each.value.dns_servers                    # optional 
  tags                           = each.value.tags                           # optional
  edge_zone                      = each.value.edge_zone                      # optional 
  flow_timeout_in_minutes        = each.value.flow_timeout_in_minutes        # optional
  private_endpoint_vnet_policies = each.value.private_endpoint_vnet_policies # optional



  # ddos_protection_plan A block 

  dynamic "ddos_protection_plan" {
    for_each = each.value.ddos_protection_plans != null ? each.value.ddos_protection_plans : {}
    content {
      id     = dos_protection_plan.value.id
      enable = dos_protection_plan.value.enable
    }
  }

  # encryption A block
  dynamic "encryption" {
    for_each = each.value.encryptions != null ? each.value.encryptions : {}
    content {
      enforcement = encryption.value.enforcement
    }
  }
  # subnet blocks
  dynamic "subnet" {
    for_each = each.value.subnets != null ? each.value.subnets : {}
    content {
      name             = subnet.value.name
      address_prefixes = subnet.value.address_prefixes
      
      default_outbound_access_enabled = subnet.value.default_outbound_access_enabled
      private_endpoint_network_policies = subnet.value.private_endpoint_network_policies
      

    }
  }
  # ip_address_pool blocks one or two
  dynamic "ip_address_pool" {
    for_each = each.value.ip_address_pools != null ? each.value.ip_address_pool : []
    content {
      id                     = ip_address_pool.value.id
      number_of_ip_addresses = ip_address_pool.value.id
    }
  }




}
