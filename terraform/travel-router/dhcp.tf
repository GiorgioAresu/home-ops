# ================================================================================================
# DHCP Client
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_client
# ================================================================================================
resource "routeros_ip_dhcp_client" "ether1" {
  comment      = "Managed by Terraform"
  interface    = routeros_interface_ethernet.ether1.name
  use_peer_dns = false
  use_peer_ntp = false
}


# ================================================================================================
# IP Address
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_address
# ================================================================================================
resource "routeros_ip_address" "lan" {
  comment   = "Managed by Terraform"
  address   = "10.17.4.1/24"
  interface = routeros_interface_bridge.bridge.name
  network   = "10.17.4.0"
}


# ================================================================================================
# DHCP Pool Range
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_pool
# ================================================================================================
resource "routeros_ip_pool" "lan" {
  comment = "Managed by Terraform"
  name    = "LAN"
  ranges  = ["10.17.4.100-10.17.4.199"]
}


# ================================================================================================
# DHCP Network Configuration
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_network
# ================================================================================================
resource "routeros_ip_dhcp_server_network" "lan" {
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
resource "routeros_ip_dhcp_server" "lan" {
  comment         = "Managed by Terraform"
  name            = "LAN"
  address_pool    = routeros_ip_pool.lan.name
  interface       = routeros_interface_bridge.bridge.name
  use_reconfigure = true
}


# ================================================================================================
# Static DHCP Leases
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_lease
# ================================================================================================
resource "routeros_ip_dhcp_server_lease" "framework" {
  comment     = "Managed by Terraform - Framework Laptop"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.4.99"
  mac_address = "9E:3C:2C:78:26:29"
}

