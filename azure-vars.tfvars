#######################
#### RESOURCE GROUP ###
#######################
rs-group = {
  name = "prod-resource-group"
}

##############################
#### STORAGE AND CONTAINER ###
##############################
storage = {
  name                     = "storage031928412903"
  account_kind             = "StorageV2"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

container = {
  name                  = "terraform"
  container_access_type = "blob"
}

########################################################
#### VNET, ROUTE-TABLE, SUBNET AND SECURITY GROUP ######
########################################################
vnet = {
  name          = "prod-vnet"
  address_space = "10.0.0.0/16"
}

routeTable = "prod-route-table"


subnets = {
  prod-subnet = {
    name                              = "prod-subnet"
    addressPrefix                     = "10.0.0.0/16"
    service_endpoints                 = ["Microsoft.KeyVault", "Microsoft.AzureActiveDirectory"]
    privateEndpointNetworkPolices     = true #???????
    privateLinkServiceNetworkPolicies = true #???????
  }
}

network-interface = {
  name             = "prod-network-interface"
  ip_configuration = {
    name                          = "Internal"
    private_ip_address_allocation = "Dynamic"
  }

}

securityGroups = {
  prod-security = {
    name          = "prod-security"
    securityRules = [
      {
        name                         = "InboundAllowance"
        description                  = "Allowance for Inbound TCP traffic"
        access                       = "Allow"
        direction                    = "Inbound"
        priority                     = 100
        protocol                     = "Tcp"
        source_port_range            = "*"
        source_port_ranges           = null
        destination_port_range       = null
        destination_port_ranges      = [80, 443, 3443]
        source_address_prefix        = "*"
        source_address_prefixes      = null
        destination_address_prefix   = "*"
        destination_address_prefixes = null
      }
    ]
  }
}

