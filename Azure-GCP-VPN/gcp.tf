resource "google_compute_network" "gcp-vpc" {
  name                    = "gcp-vpc"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_subnetwork" "public_subnet" {
  name                     = "public-subnet"
  ip_cidr_range            = var.gcp_cidr[0]
  region                   = var.gcp_region
  network                  = google_compute_network.gcp-vpc.name
  private_ip_google_access = true
}
resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet"
  ip_cidr_range            = var.gcp_cidr[1]
  region                   = var.gcp_region
  network                  = google_compute_network.gcp-vpc.name
  private_ip_google_access = true
}

resource "google_compute_router" "gcp-router" {
  name    = "gcp-router"
  region  = var.gcp_region
  network = google_compute_network.gcp-vpc.id

  bgp {
    asn               = var.gcp_bgp_asn
    advertise_mode    = "CUSTOM"
    advertised_groups = ["ALL_SUBNETS"]
  }
}

resource "google_compute_router_nat" "gcp-nat" {
  name                               = "gcp-nat-router"
  router                             = google_compute_router.gcp-router.name
  region                             = var.gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}

resource "google_compute_ha_vpn_gateway" "gcp-gateway" {
  name       = "azure-vpn"
  region     = var.gcp_region
  network    = google_compute_network.gcp-vpc.name
  stack_type = "IPV4_IPV6"
}

resource "google_compute_external_vpn_gateway" "azure-gateway" {
  name            = "azure-gateway"
  redundancy_type = "FOUR_IPS_REDUNDANCY"
  description     = "VPN gateway on Azure side"
  interface {
    id         = 0
    ip_address = azurerm_public_ip.public_ip_1.ip_address
  }
  interface {
    id         = 1
    ip_address = azurerm_public_ip.public_ip_1.ip_address
  }
  interface {
    id         = 2
    ip_address = azurerm_public_ip.public_ip_2.ip_address
  }
  interface {
    id         = 3
    ip_address = azurerm_public_ip.public_ip_2.ip_address
  }
}

resource "google_compute_vpn_tunnel" "vpn1" {
  name                            = "azure-vpn-tunnel-1"
  peer_external_gateway           = google_compute_external_vpn_gateway.azure-gateway.id
  peer_external_gateway_interface = 0
  shared_secret                   = random_password.password.result
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-gateway.self_link
  router                          = google_compute_router.gcp-router.name
  vpn_gateway_interface           = 0
}

resource "google_compute_router_peer" "peer1" {
  name            = "peer-1"
  router          = google_compute_router.gcp-router.name
  region          = google_compute_router.gcp-router.region
  peer_ip_address = cidrhost("169.254.21.0/30", 2)
  peer_asn        = var.azure_bgp_asn
  interface       = google_compute_router_interface.int1.name
}

resource "google_compute_router_interface" "int1" {
  name       = "interface-1"
  router     = google_compute_router.gcp-router.name
  region     = google_compute_router.gcp-router.region
  ip_range   = "169.254.21.0/30"
  vpn_tunnel = google_compute_vpn_tunnel.vpn1.name
}

resource "google_compute_vpn_tunnel" "vpn2" {
  name                            = "azure-vpn-tunnel-2"
  peer_external_gateway           = google_compute_external_vpn_gateway.azure-gateway.id
  peer_external_gateway_interface = 1
  shared_secret                   = random_password.password.result
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-gateway.self_link
  router                          = google_compute_router.gcp-router.name
  vpn_gateway_interface           = 0
}

resource "google_compute_router_peer" "peer2" {
  name            = "peer-2"
  router          = google_compute_router.gcp-router.name
  region          = google_compute_router.gcp-router.region
  peer_ip_address = cidrhost("169.254.21.4/30", 2)
  peer_asn        = var.azure_bgp_asn
  interface       = google_compute_router_interface.int2.name
}

resource "google_compute_router_interface" "int2" {
  name       = "interface-2"
  router     = google_compute_router.gcp-router.name
  region     = google_compute_router.gcp-router.region
  ip_range   = "169.254.21.4/30"
  vpn_tunnel = google_compute_vpn_tunnel.vpn2.name
}

resource "google_compute_vpn_tunnel" "vpn3" {
  name                            = "azure-vpn-tunnel-3"
  peer_external_gateway           = google_compute_external_vpn_gateway.azure-gateway.id
  peer_external_gateway_interface = 2
  shared_secret                   = random_password.password.result
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-gateway.self_link
  router                          = google_compute_router.gcp-router.name
  vpn_gateway_interface           = 1
}

resource "google_compute_router_peer" "peer3" {
  name            = "peer-3"
  router          = google_compute_router.gcp-router.name
  region          = google_compute_router.gcp-router.region
  peer_ip_address = cidrhost("169.254.22.0/30", 2)
  peer_asn        = var.azure_bgp_asn
  interface       = google_compute_router_interface.int3.name
}

resource "google_compute_router_interface" "int3" {
  name       = "interface-3"
  router     = google_compute_router.gcp-router.name
  region     = google_compute_router.gcp-router.region
  ip_range   = "169.254.22.0/30"
  vpn_tunnel = google_compute_vpn_tunnel.vpn3.name
}

resource "google_compute_vpn_tunnel" "vpn4" {
  name                            = "azure-vpn-tunnel-4"
  peer_external_gateway           = google_compute_external_vpn_gateway.azure-gateway.id
  peer_external_gateway_interface = 3
  shared_secret                   = random_password.password.result
  ike_version                     = 2
  vpn_gateway                     = google_compute_ha_vpn_gateway.gcp-gateway.self_link
  router                          = google_compute_router.gcp-router.name
  vpn_gateway_interface           = 2
}

resource "google_compute_router_peer" "peer4" {
  name            = "peer-4"
  router          = google_compute_router.gcp-router.name
  region          = google_compute_router.gcp-router.region
  peer_ip_address = cidrhost("169.254.22.4/30", 2)
  peer_asn        = var.azure_bgp_asn
  interface       = google_compute_router_interface.int4.name
}

resource "google_compute_router_interface" "int4" {
  name       = "interface-4"
  router     = google_compute_router.gcp-router.name
  region     = google_compute_router.gcp-router.region
  ip_range   = "169.254.22.4/30"
  vpn_tunnel = google_compute_vpn_tunnel.vpn4.name
}
