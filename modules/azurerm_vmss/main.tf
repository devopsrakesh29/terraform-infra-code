resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  for_each                        = var.vmss
  name                            = each.value.vmss_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  sku                             = each.value.sku       #"Standard_F2"
  instances                       = each.value.instances #1
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = each.value.disable_password_authentication

  dynamic "admin_ssh_key" {
    for_each = each.value.admin_ssh_key != null ? each.value.admin_ssh_key : {}
    content {
      username   = admin_ssh_key.value.username #"adminuser"
      public_key = admin_ssh_key.value.public_key
    }
  }

  source_image_reference {
    publisher = each.value.source_image_reference.publisher #"Canonical"
    offer     = each.value.source_image_reference.offer     #"0001-com-ubuntu-server-jammy"
    sku       = each.value.source_image_reference.sku       #"22_04-lts"
    version   = each.value.source_image_reference.version   #"latest"
  }


  os_disk {
    storage_account_type = each.value.os_disk.storage_account_type #"Standard_LRS"
    caching              = each.value.os_disk.caching              #"ReadWrite"
  }

  dynamic "network_interface" {
    for_each = each.value.network_interfaces
    content {
      name    = network_interface.value.name    #"example"
      primary = network_interface.value.primary #true
      dynamic "ip_configuration" {
        for_each = network_interface.value.ip_configuration
        content {
          name      = ip_configuration.value.name    #"internal"
          primary   = ip_configuration.value.primary #true
          subnet_id = data.azurerm_subnet.subnet[each.key].id
        }
      }
    }
  }
}
