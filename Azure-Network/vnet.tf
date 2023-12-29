resource "azurerm_virtual_network" "vnet" {
  name                = "VNET"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.123.0.0/16"]
  tags                = var.tags
}
