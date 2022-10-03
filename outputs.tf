data "azurerm_virtual_network" "vnet" {
  name                = "prod-vnet"
  resource_group_name = "prod-resource-group"
}

output "adsad" {
  value = azurerm_virtual_network.vnet.id
}
output "adseqwed" {
  value = azurerm_virtual_network.vnet.name
}
output "adeqweqeqwsad" {
  value = azurerm_virtual_network.vnet.location
}