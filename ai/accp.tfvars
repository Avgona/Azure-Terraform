#######################
#### RESOURCE GROUP ###
#######################
resourceGroupName = "some-resource-group"

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
  name = "iagadsca01-cac-vnet-spoke-01"
}

routeTable = {
  name = "routeTables_iagadscd01_cac_udr_spoke_01_externalid"
}

securityGroups = {
  name = "networkSecurityGroup_iagadscd01_cac_nsg_default_01_externalid"
}


subnets = {
  prod-subnet = {
    name                              = "${var.vnet.name}-sub-rke2-10.103.78.0/26"
    addressPrefix                     = "10.103.78.0/26"
    service_endpoints                 = ["Microsoft.Storage", "Microsoft.KeyVault"]
    privateEndpointNetworkPolices     = false
    privateLinkServiceNetworkPolicies = true
  }
}

