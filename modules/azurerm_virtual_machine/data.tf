data "azurerm_subnet" "subnet" {
    for_each = var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "pip" {
    for_each = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.resource_group_name

}

data "azurerm_key_vault" "kv" {
  for_each = var.vms
  name                = each.value.key_vault_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "username" {
     for_each = var.vms
  name         = each.value.username
  key_vault_id = data.azurerm_key_vault.kv[each.key].id 

}

data "azurerm_key_vault_secret" "password" {
     for_each = var.vms
  name         = each.value.password
  key_vault_id = data.azurerm_key_vault.kv[each.key].id 

}


