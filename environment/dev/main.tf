# module "resource_group" {
#   source = "../../modules/azurerm_resource_group"
#   providers = {
#     azurerm = azurerm.resource_group_provider
#   }
#   for_each    = var.resource_groups
#   rg_name     = each.value.name
#   rg_location = each.value.location
#   rg_tags     = each.value.tags
#   # rg_subscription_id = var.rg_subscription_id
# }
# #---------------------------------------------
# module "storage_account" {
#   source     = "../../modules/azurerm_storage_account"
#   depends_on = [module.resource_group]
#   providers = {
#     azurerm = azurerm.storage_account_provider
#   }

#   for_each                      = var.storage_accounts
#   storage_account_name          = each.value.stg_name
#   rg_name                       = module.resource_group["rg01"].rg_name
#   location                      = module.resource_group["rg01"].rg_location
#   account_tier                  = each.value.account_tier
#   account_replication_type      = each.value.account_replication_type
#   min_tls_version               = each.value.min_tls_version
#   access_tier                   = each.value.access_tier
#   public_network_access_enabled = each.value.public_network_access_enabled
#   tags                          = each.value.tags

# }
# #---------------------------------------------
# module "vnet" {
#   source     = "../../modules/azurerm_vnet"
#   depends_on = [module.resource_group]
#   providers = {
#     azurerm = azurerm.vnet_provider
#   }
#   virtual_networks = var.virtual_networks
# }
# #---------------------------------------------
# module "nsg" {
#   source     = "../../modules/azurerm_nsg"
#   depends_on = [module.resource_group]
#   nsgs       = var.nsgs

#   providers = {
#     azurerm = azurerm.vnet_provider
#   }

# }

# #---------------------------------------------

# module "key_vault" {
#   source = "../../modules/azurerm_key_vault"
#   depends_on = [module.resource_group]
#   providers = {
#     azurerm = azurerm.resource_group_provider
#   }
#   kvs = var.kvs
# }

# #---------------------------------------------

# module "kv_secret" {
#   depends_on = [module.key_vault]
#   source     = "../../modules/azurerm_kv_secret"
#   providers = {
#     azurerm = azurerm.resource_group_provider
#   }
#   kv_secrets          = var.kv_secrets
  
# }

# #---------------------------------------------

# module "public_ip" {
#   source = "../../modules/azurerm_public_ip"
#   providers = {
#     azurerm = azurerm.resource_group_provider
#   }
#   depends_on = [module.resource_group]
#   pips       = var.pips
# }


# #---------------------------------------------

# module "nsg_nic" {
#   depends_on = [module.virtual_machine, module.nsg, module.resource_group]
#   source     = "../../modules/azurerm_network_interface_security_group_association"
#   providers = {
#     azurerm = azurerm.resource_group_provider
#   }
#   nsg_name            = var.nsg_name
#   nic_name            = var.nic_name
#   resource_group_name = var.resource_group_name

# }

# #---------------------------------------------

# module "virtual_machine" {
#   depends_on = [ module.kv_secret]
#     providers = {
#     azurerm = azurerm.resource_group_provider
#   }
#   source = "../../modules/azurerm_virtual_machine"
#   vms= var.vms
#    }


#---------------------------------------------

module "k8s_cluster" {
  source = "../../modules/azurerm_k8s_services"
  depends_on = [module.resource_group]
    providers = {
    azurerm = azurerm.resource_group_provider
  }
  kubernetes_clusters = var.kubernetes_clusters

}

#----------------------------------------------

# module "database" {
#   source = "../../modules/azurerm_db_services"
#   depends_on = [ module.kv_secret, module.storage_account ]
#      providers = {
#     azurerm = azurerm.resource_group_provider
#   }

#   databases = var.databases
  
# }

#----------------------------------------------
# module "bastion_host" {
#   source = "../../modules/azurerm_bastion_host"
#   depends_on = [ module.public_ip, module.vnet ]
#   bastion_hosts= var.bastion_hosts
#   providers = {
#     azurerm = azurerm.vnet_provider
#   }
# }
