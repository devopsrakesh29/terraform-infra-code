resource "azurerm_network_interface" "nic" {
  for_each                       = var.vms
  name                           = each.value.nic_name
  location                       = each.value.location
  resource_group_name            = each.value.resource_group_name
  auxiliary_mode                 = each.value.auxiliary_mode                 # optional string none
  auxiliary_sku                  = each.value.auxiliary_sku                  # optional
  dns_servers                    = each.value.dns_servers                    # optional
  edge_zone                      = each.value.edge_zone                      # optional
  ip_forwarding_enabled          = each.value.ip_forwarding_enabled          # optional default false
  accelerated_networking_enabled = each.value.accelerated_networking_enabled # optional
  internal_dns_name_label        = each.value.internal_dns_name_label        # optional
  tags                           = each.value.tags

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name                                               = ip_configuration.value.name #"internal"
      subnet_id                                          = data.azurerm_subnet.subnet[each.key].id
      private_ip_address_allocation                      = ip_configuration.value.private_ip_address_allocation                      # "Dynamic"
      gateway_load_balancer_frontend_ip_configuration_id = ip_configuration.value.gateway_load_balancer_frontend_ip_configuration_id # optional
      public_ip_address_id                               = data.azurerm_public_ip.pip[each.key].id
      primary                                            = ip_configuration.value.primary # optional false
    }
  }

}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each                        = var.vms
  name                            = each.value.vm_name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size                                        # "Standard_F2"
  admin_username                  = data.azurerm_key_vault_secret.username[each.key].value # optional
  admin_password                  = data.azurerm_key_vault_secret.password[each.key].value # optional
  disable_password_authentication = each.value.disable_password_authentication             # optional false 
  network_interface_ids           = [azurerm_network_interface.nic[each.key].id]
  tags                            = each.value.tags

  dynamic "admin_ssh_key" {
    for_each = each.value.admin_ssh_keys != null ? each.value.admin_ssh_keys : {}
    content {
      username   = admin_ssh_key.value.username
      public_key = admin_ssh_key.value.public_key # file("~/.ssh/id_rsa.pub")
    }
  }
  dynamic "os_disk" {

    for_each = each.value.os_disks
    content {
      caching              = os_disk.value.caching              # "ReadWrite"
      storage_account_type = os_disk.value.storage_account_type #"Standard_LRS"
    }
  }
  dynamic "source_image_reference" {
    for_each = each.value.source_image_references
    content {
      publisher = source_image_reference.value.publisher #"Canonical"
      offer     = source_image_reference.value.offer     #"0001-com-ubuntu-server-jammy"
      sku       = source_image_reference.value.sku       #"22_04-lts"
      version   = source_image_reference.value.version   #"latest"
    }
  }
  custom_data = base64encode(file("${each.value.custom_data}"))
}

