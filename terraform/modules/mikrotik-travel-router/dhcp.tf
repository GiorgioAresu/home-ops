# ================================================================================================
# DHCP Client
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_client
# ================================================================================================
# resource "routeros_ip_dhcp_client" "travel_wan" {
#   comment      = "Managed by Terraform"
#   interface    = "bridge_wan"
#   use_peer_dns = false
#   use_peer_ntp = false
# }


# ================================================================================================
# IP Address
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_address
# ================================================================================================
resource "routeros_ip_address" "travel_lan" {
  comment   = "Managed by Terraform"
  address   = "10.17.4.1/24"
  interface = routeros_interface_bridge.travel_bridge.name
  network   = "10.17.4.0"
}


# ================================================================================================
# DHCP Pool Range
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_pool
# ================================================================================================
resource "routeros_ip_pool" "travel_lan" {
  comment = "Managed by Terraform"
  name    = "LAN"
  ranges  = ["10.17.4.100-10.17.4.199"]
}


# ================================================================================================
# DHCP Network Configuration
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_network
# ================================================================================================
resource "routeros_ip_dhcp_server_network" "travel_lan" {
  comment    = "Managed by Terraform"
  address    = "10.17.4.0/24"
  gateway    = "10.17.4.1"
  dns_server = ["10.17.4.1"]
  ntp_server = ["10.17.4.1"]
  domain     = "travel.aresu.eu"
}


# ================================================================================================
# DHCP Server Configuration
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server
# ================================================================================================
resource "routeros_ip_dhcp_server" "travel_lan" {
  comment         = "Managed by Terraform"
  name            = "LAN"
  address_pool    = routeros_ip_pool.travel_lan.name
  interface       = routeros_interface_bridge.travel_bridge.name
  use_reconfigure = true
}


# ================================================================================================
# Static DHCP Leases
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_lease
# ================================================================================================
resource "routeros_ip_dhcp_server_lease" "travel_framework" {
  comment     = "Managed by Terraform - Framework Laptop"
  server      = routeros_ip_dhcp_server.travel_lan.name
  address     = "10.17.4.99"
  mac_address = "9E:3C:2C:78:26:29"
}

