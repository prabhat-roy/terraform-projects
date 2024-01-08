resource "azurerm_network_security_group" "ssh" {
  name                = "ssh"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
      name                         = "ssh"
      description                  = "ssh"
      priority                     = 100
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Tcp"
      source_port_range           = "*"
      destination_port_range      = "22"
      source_address_prefix        = "*"
      destination_address_prefix = var.my_ip
    }
}

resource "azurerm_network_security_group" "aws_icmp" {
  name                = "aws_icmp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {   
      name                         = "aws_icmp"
      description                  = "aws_icmp"
      priority                     = 110
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Icmp"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix        = "*"
      destination_address_prefix = var.aws_vpc_cidr
    }
}

resource "azurerm_network_security_group" "gcp_icmp" {
  name                = "gcp_icmp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  security_rule {
      name                         = "gcp_icmp"
      description                  = "gcp_icmp"
      priority                     = 120
      direction                    = "Inbound"
      access                       = "Allow"
      protocol                     = "Icmp"
      source_port_range           = "*"
      destination_port_range      = "*"
      source_address_prefix        = "*"
      destination_address_prefix = var.gcp_cidr
    }
}

