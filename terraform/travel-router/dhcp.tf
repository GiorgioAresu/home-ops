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
  interface = routeros_interface_bridge.bridge_lan.name
  network   = "10.17.4.0"
}
# resource "routeros_ip_address" "tunnel" {
#   comment   = "Managed by Terraform"
#   address   = "10.17.10.1/24"
#   interface = routeros_interface_vlan.home.name
#   network   = "10.17.10.0"
# }


# ================================================================================================
# DHCP Pool Range
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_pool
# ================================================================================================
resource "routeros_ip_pool" "lan" {
  comment = "Managed by Terraform"
  name    = "lan"
  ranges  = ["10.17.4.100-10.17.4.199"]
}
# resource "routeros_ip_pool" "tunnel" {
#   comment = "Managed by Terraform"
#   name    = "tunnel"
#   ranges  = ["10.17.10.100-10.17.10.199"]
# }


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
# resource "routeros_ip_dhcp_server_network" "tunnel" {
#   comment    = "Managed by Terraform"
#   address    = "10.17.10.0/24"
#   gateway    = "10.17.10.1"
#   dns_server = ["10.17.10.1"]
#   ntp_server = ["10.17.10.1"]
#   domain     = "home.aresu.eu"
# }

# ================================================================================================
# DHCP Server Configuration
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server
# ================================================================================================
resource "routeros_ip_dhcp_server" "lan" {
  comment         = "Managed by Terraform"
  name            = "lan"
  address_pool    = routeros_ip_pool.lan.name
  interface       = routeros_interface_bridge.bridge_lan.name
  use_reconfigure = true
}
# resource "routeros_ip_dhcp_server" "tunnel" {
#   comment         = "Managed by Terraform"
#   name            = "tunnel"
#   address_pool    = routeros_ip_pool.tunnel.name
#   interface       = routeros_interface_vlan.home.name
#   use_reconfigure = true
# }


# ================================================================================================
# Static DHCP Leases
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_lease
# ================================================================================================
resource "routeros_ip_dhcp_server_lease" "lan_framework" {
  comment     = "Managed by Terraform - Framework Laptop"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.4.99"
  mac_address = "9E:3C:2C:78:26:29"
}
# resource "routeros_ip_dhcp_server_lease" "tunnel_framework" {
#   comment     = "Managed by Terraform - Framework Laptop"
#   server      = routeros_ip_dhcp_server.tunnel.name
#   address     = "10.17.10.99"
#   mac_address = "9E:3C:2C:78:26:29"
# }
