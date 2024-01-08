resource "aws_vpc" "aws_vpc" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "AWS VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.aws_vpc.id
  cidr_block              = element(var.public_subnet_cidrs, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id           = aws_vpc.aws_vpc.id
  propagating_vgws = [aws_vpn_gateway.vpn_gateway.id]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.aws_vpc.id
  tags = {
    Name = "Internet Gateway"
  }
}

resource "aws_vpn_gateway" "vpn_gateway" {
  vpc_id          = aws_vpc.aws_vpc.id
  amazon_side_asn = var.aws_bgp_asn
  tags = {
    Name = "AWS VGW"
  }
}

resource "aws_customer_gateway" "azure-cgw1" {
  bgp_asn    = var.azure_bgp_asn
  ip_address = azurerm_public_ip.public_ip_1.ip_address
  type       = "ipsec.1"
  tags = {
    Name = "Azure Public IP 1"
  }
}

resource "aws_customer_gateway" "azure-cgw2" {
  bgp_asn    = var.azure_bgp_asn
  ip_address = azurerm_public_ip.public_ip_2.ip_address
  type       = "ipsec.1"
  tags = {
    Name = "Azure Public IP 2"
  }
}


resource "aws_vpn_connection" "azure-vpn1" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.azure-cgw1.id
  type                = "ipsec.1"
  static_routes_only  = false
  tunnel1_inside_cidr = "169.254.21.0/30"
  tunnel2_inside_cidr = "169.254.21.4/30"
  tags = {
    Name = "Azure VPN 1"
  }
}

resource "aws_vpn_connection" "azure-vpn2" {
  vpn_gateway_id      = aws_vpn_gateway.vpn_gateway.id
  customer_gateway_id = aws_customer_gateway.azure-cgw2.id
  type                = "ipsec.1"
  static_routes_only  = false
  tunnel1_inside_cidr = "169.254.22.0/30"
  tunnel2_inside_cidr = "169.254.22.4/30"
  tags = {
    Name = "Azure VPN 2"
  }
}

