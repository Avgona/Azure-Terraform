#######################
######## LOCALS #######
#######################
locals {
  location = "Canada East"
}


#######################
#### RESOURCE GROUP ###
#######################

variable "resourceGroupName" {
  type = string
}

##############################
#### STORAGE AND CONTAINER ###
##############################

variable "storage" {
  type = object({
    name                     = string
    account_kind             = string
    account_tier             = string
    account_replication_type = string
  })
}

variable "container" {
  type = object({
    name                  = string
    container_access_type = string
  })
}

##############################
#### VNET, ROUTE-TABLE, SUBNET AND .... ###
##############################

variable "vnet" {
  type = object({
    name          = string
    resourceGroup = string
  })
}

variable "routeTable" {
  type = object({
    name          = string
    resourceGroup = string
  })
}

variable "subnets" {
  type = map(object({
    name                              = string
    addressPrefix                     = string
    service_endpoints                 = list(string)
    privateEndpointNetworkPolices     = bool
    privateLinkServiceNetworkPolicies = bool
  }))
  description = "Variable map for subnets"
}


variable "securityGroups" {
  type = object({
    name                = string
    resource_group_name = string
  })
}