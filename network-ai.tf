resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  address_space       = [var.vnet.address_space]
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
}


resource "azurerm_route_table" "route-table" {
  name                = var.routeTable
  location            = local.location
  resource_group_name = azurerm_resource_group.resource_group.name
}


resource "azurerm_subnet" "subnet" {
  depends_on = [azurerm_network_security_group.security-group]
  for_each   = var.subnets
  name                                           = each.value.name
  resource_group_name                            = azurerm_resource_group.resource_group.name
  virtual_network_name                           = azurerm_virtual_network.vnet.name
  address_prefixes                               = [each.value.addressPrefix]
  service_endpoints                              = each.value.service_endpoints
  enforce_private_link_service_network_policies  = each.value.privateLinkServiceNetworkPolicies
  enforce_private_link_endpoint_network_policies = each.value.privateEndpointNetworkPolices
}

resource "azurerm_network_security_group" "security-group" {
  for_each = var.securityGroups

  name                = each.value.name
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name

  dynamic "security_rule" {
    for_each = each.value.securityRules
    content {
      name                         = security_rule.value.name
      description                  = security_rule.value.description
      access                       = security_rule.value.access
      direction                    = security_rule.value.direction
      priority                     = security_rule.value.priority
      protocol                     = security_rule.value.protocol
      source_port_range            = security_rule.value.source_port_range
      source_port_ranges           = security_rule.value.source_port_ranges
      destination_port_range       = security_rule.value.destination_port_range
      destination_port_ranges      = security_rule.value.destination_port_ranges
      source_address_prefix        = security_rule.value.source_address_prefix
      source_address_prefixes      = security_rule.value.source_address_prefixes
      destination_address_prefix   = security_rule.value.destination_address_prefix
      destination_address_prefixes = security_rule.value.destination_address_prefixes
    }
  }
}


resource "azurerm_network_interface" "network-interface" {
  depends_on = [azurerm_subnet.subnet]
  for_each   = azurerm_subnet.subnet

  name                = var.network-interface.name
  location            = local.location
  resource_group_name = azurerm_resource_group.resource_group.name

  ip_configuration {
    name                          = var.network-interface.ip_configuration.name
    subnet_id                     = each.value.id
    private_ip_address_allocation = var.network-interface.ip_configuration.private_ip_address_allocation
  }
}


#resource "azurerm_subnet_network_security_group_association" "route-table-association" {
#  depends_on = [azurerm_network_security_group.security-group]
#  for_each   = azurerm_subnet.subnet
#
#  subnet_id                 = each.value.id
#  network_security_group_id = azurerm_network_security_group.security-group.id
#}


#resource "azurerm_network_interface_security_group_association" "interface-security-group-association" {
#  depends_on = [azurerm_network_interface.network-interface, azurerm_network_security_group.security-group]
#  network_interface_id      = azurerm_network_interface.network-interface.id
#  network_security_group_id = azurerm_network_security_group.security-group.id
#}