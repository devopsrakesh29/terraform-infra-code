
resource "azurerm_bastion_host" "bastion_host" {
  for_each            = var.bastion_hosts
  name                = each.value.bastion_name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations


    content {
      name                 = ip_configuration.value.name #"configuration"
      subnet_id            = data.azurerm_subnet.subnet[each.key].id
      public_ip_address_id = data.azurerm_public_ip.pip[each.key].id
    }
  }
}
