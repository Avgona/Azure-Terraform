data "azurerm_virtual_network" "vnet" {
  name                = var.vnet.name
  resource_group_name = data.azurerm_resource_group.resource-group.name
}

data "azurerm_route_table" "route-table" {
  name                = var.routeTable.name
  resource_group_name = data.azurerm_resource_group.resource-group.name
}

data "azurerm_network_security_group" "network_security_group" {
  for_each            = var.routeTable
  name                = var.securityGroups.name
  resource_group_name = data.azurerm_resource_group.resource-group.name
}

resource "azurerm_subnet" "subnet" {
  for_each = var.subnets

  name                                           = each.value.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  resource_group_name                            = data.azurerm_virtual_network.vnet.resource_group_name
  address_prefixes                               = [each.value.addressPrefix]
  service_endpoints                              = each.value.service_endpoints
  enforce_private_link_service_network_policies  = each.value.privateLinkServiceNetworkPolicies
  enforce_private_link_endpoint_network_policies = each.value.privateEndpointNetworkPolices
}

resource "azurerm_subnet_network_security_group_association" "rsubnet_network_security_group_association" {
  depends_on = [azurerm_subnet.subnet]
  for_each   = azurerm_subnet.subnet

  subnet_id                 = each.value.id
  network_security_group_id = data.azurerm_network_security_group.network_security_group.id
}

resource "azurerm_subnet_route_table_association" "example" {
  depends_on = [azurerm_subnet.subnet]
  for_each   = azurerm_subnet.subnet

  subnet_id      = each.value.id
  route_table_id = data.azurerm_route_table.route-table.id
}