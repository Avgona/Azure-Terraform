#######################
######## LOCALS #######
#######################
locals {
  location = "Canada East"
}


#######################
#### RESOURCE GROUP ###
#######################

variable "rs-group" {
  type = object({
    name = string
  })
  description = "Variables for resource group"
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
  description = "Variables for Storage"
}

variable "container" {
  type = object({
    name                  = string
    container_access_type = string
  })
  description = "Variables for Storage.Container"
}

##############################
#### VNET, ROUTE-TABLE, SUBNET AND .... ###
##############################

variable "vnet" {
  type = object({
    name          = string
    address_space = string
  })
  description = "Variable for vnet name"
}

variable "routeTable" {
  type = string
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

variable "network-interface" {
  type = object({
    name = string
    ip_configuration = object({
      name                          = string
      private_ip_address_allocation = string
    })
  })
}

variable "securityGroups" {
  type = map(object({
    name          = string
    securityRules = list(object({
      name                         = string
      description                  = string
      access                       = string
      direction                    = string
      priority                     = number
      protocol                     = string
      source_port_range            = string
      source_port_ranges           = list(string)
      destination_port_range       = string
      destination_port_ranges      = list(string)
      source_address_prefix        = string
      source_address_prefixes      = list(string)
      destination_address_prefix   = string
      destination_address_prefixes = list(string)
    }))
  }))
  description = "Variable map for security group and inbound & outbound traffic"
}