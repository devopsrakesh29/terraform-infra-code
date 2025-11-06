storage_accounts = {
  "stg1" = {
    stg_name                 = "rakeshb17stg1"
    account_tier             = "Standard"
    account_replication_type = "LRS"
    access_tier              = "Hot"
    https_traffic_only       = true
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }

  }
  "stg2" = {
    stg_name                 = "rakeshb17stg2"
    account_tier             = "Standard"
    account_replication_type = "GRS"
    min_tls_version          = "TLS1_2"
    access_tier              = "Cool"

    public_network_access_enabled = true
  }
}

resource_groups = {
  "rg01" = {
    name     = "rakesh-rg"
    location = "East US"
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
  }
}

rg_subscription_id              = "b37d1b55-e5e8-4acb-a848-fd89484f0997"
storage_account_subscription_id = "b37d1b55-e5e8-4acb-a848-fd89484f0997"
vnet_subscription_id            = "b37d1b55-e5e8-4acb-a848-fd89484f0997"

virtual_networks = {
  vnet1 = {
    name                = "rakeshvnet01"
    location            = "centralindia"
    resource_group_name = "rakesh-rg"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = ["10.0.0.4"]

    subnets = [
      {
        name             = "rakesh-subnet-01"
        address_prefixes = ["10.0.1.0/24"]

      },

      {
        name             = "rakesh-subnet-02"
        address_prefixes = ["10.0.2.0/24"]

      }
    ]
  }

  vnet2 = {
    name                = "rakeshvnet02"
    location            = "centralindia"
    resource_group_name = "rakesh-rg"
    address_space       = ["10.1.0.0/16"]
    dns_servers         = ["10.1.0.4"]

    subnets = [
      {
        name             = "rakesh-subnet-03"
        address_prefixes = ["10.1.1.0/24"]
      },

      {
        name             = "rakesh-subnet-04"
        address_prefixes = ["10.1.2.0/24"]
      }

    ]
  }
}


# NSG

nsgs = {
  nsg1 = {
    name                = "jumpnsg"
    location            = "centralindia"
    resource_group_name = "rakesh-rg"
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
    security_rules = {
      sr1 = {
        name                       = "ssh"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
      sr2 = {
        name                       = "internet"
        priority                   = 101
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "443"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    }
  }
}

# key vault

kvs = {
  kv1 = {
    name                        = "rakeshkv006"
    location                    = "centralindia"
    resource_group_name         = "rakesh-rg"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 30
    purge_protection_enabled    = true
    sku_name                    = "standard"
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
  }
}

# key vault secret

kv_secrets = {
  kvs1 = {
    key_vault_secret_name  = "vm1-username"
    key_vault_secret_value = "azureuser"
    key_vault_name         = "rakeshkv006"
    resource_group_name    = "rakesh-rg"
  }

  kvs2 = {
    key_vault_secret_name  = "vm1-password"
    key_vault_secret_value = "Password@@12345"
    key_vault_name         = "rakeshkv006"
    resource_group_name    = "rakesh-rg"
  }

  kvs3 = {
    key_vault_secret_name  = "db1-username"
    key_vault_secret_value = "azureuser"
    key_vault_name         = "rakeshkv006"
    resource_group_name    = "rakesh-rg"
  }

  kvs3 = {
    key_vault_secret_name  = "db1-password"
    key_vault_secret_value = "Password@@12345"
    key_vault_name         = "rakeshkv006"
    resource_group_name    = "rakesh-rg"
  }
}


resource_group_name = "rakesh-rg"

# public ip
pips = {
  pip1 = {
    name                = "rakeshpip1"
    resource_group_name = "rakesh-rg"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
  }
}



# NSG_NIC association

nsg_name = "jumpnsg"
nic_name = "rakeshnic1"

# Virtual Machine

vms = {
  vm1 = {
    vm_name                         = "rakeshvm"
    nic_name                        = "rakeshnic1"
    subnet_name                     = "rakesh-subnet-01"
    vnet_name                       = "rakeshvnet01"
    pip_name                        = "rakeshpip1"
    key_vault_name                  = "rakeshkv006"
    username                        = "vm1-username"
    password                        = "vm1-password"
    resource_group_name             = "rakesh-rg"
    location                        = "centralindia"
    size                            = "Standard_F2"
    disable_password_authentication = false

    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
    ip_configurations = {
      ipc1 = {
        name                          = "internal"
        private_ip_address_allocation = "Dynamic"
      }
    }
    os_disks = {
      disk1 = {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
      }
    }

    source_image_references = {
      image = {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"

      }
    }
    custom_data = <<EOF
#!/bin/bash
sudo apt-get update -y
sudo apt-get install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
EOF

  }
}

kubernetes_clusters = {
  cluster1 = {
    acr_name                         = "rakeshacr"
    sku                              = "Premium"
    skip_service_principal_aad_check = true
    role_definition_name             = "Acrpull"
    aks_name                         = "rakeshakscluster"
    location                         = "centralindia"
    resource_group_name              = "rakesh-rg"
    dns_prefix                       = "rakesh-dev"
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
    default_node_pool = {
      pool1 = {
        name       = "default"
        node_count = 1
        vm_size    = "Standard_D2pds_v5"
      }
    }

    identity = {
      identity = {
        type = "SystemAssigned"
      }
    }
  }
}

databases = {
  "db1" = {
    dbserver_name       = "rakeshdbs01"
    resource_group_name = "rakesh-rg"
    location            = "centralindia"
    version             = "12.0"
    tags = {
      environment = "dev"
      owner       = "rakesh"
      project     = "terraform-azure"
    }
    sql_database_name = "rakeshsqldb01"
    key_vault_name    = "rakeshkv006"
    username          = "vm1-username"
    password          = "vm1-password"
    collation         = "SQL_Latin1_General_CP1_CI_AS"
    license_type      = "LicenseIncluded"
    max_size_gb       = 2
    sku_name          = "S0"
    enclave_type      = "VBS"

  }
}

