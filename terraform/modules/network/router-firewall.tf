# ================================================================================================
# Firewall: NAT
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_nat
# ================================================================================================
resource "routeros_ip_firewall_nat" "syncthing_tcp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - SyncThing TCP"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "tcp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 22000
  to_addresses      = "10.17.1.212"
}
resource "routeros_ip_firewall_nat" "syncthing_udp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - SyncThing UDP"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 22000
  to_addresses      = "10.17.1.212"
}

resource "routeros_ip_firewall_nat" "ingress" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - Ingress"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "tcp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 443
  to_addresses      = "10.17.1.201"
}

resource "routeros_ip_firewall_nat" "qbittorrent_tcp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - QBittorrent TCP"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "tcp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 52015
  to_addresses      = "10.17.1.215"
}
resource "routeros_ip_firewall_nat" "qbittorrent_udp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - QBittorrent UDP"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 52015
  to_addresses      = "10.17.1.216"
}

resource "routeros_ip_firewall_nat" "ntp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - Redirect all NTP to local"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 123
  to_addresses      = "10.17.1.1"
  log               = false
  log_prefix        = ""
}
resource "routeros_ip_firewall_nat" "dns" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - Redirect all DNS to local"
  disabled          = true
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 53
  to_addresses      = "10.17.1.1"
}
