
resource "azurerm_public_ip" "lbip" {
  name                = "Load-Balancer-Public-IP"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = random_string.fqdn.result
  tags                = var.tags
}