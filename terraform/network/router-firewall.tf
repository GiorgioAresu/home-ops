# ================================================================================================
# FIREWALL NAT
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_nat
# ================================================================================================
resource "routeros_ip_firewall_nat" "wan" {
  provider           = routeros.rb5009
  comment            = "Managed by Terraform - WAN masquerade"
  chain              = "srcnat"
  action             = "masquerade"
  out_interface_list = routeros_interface_list.wan.name
  log                = false
}
resource "routeros_ip_firewall_nat" "vpn_exit" {
  provider      = routeros.rb5009
  comment       = "Managed by Terraform - VPN Exit masquerade"
  chain         = "srcnat"
  action        = "masquerade"
  out_interface = routeros_interface_wireguard.vpn_exit.name
  log           = false
}

resource "routeros_ip_firewall_nat" "syncthing_tcp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - SyncThing TCP"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "tcp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 22000
  to_addresses      = "10.1.1.212"
  log               = false
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
  to_addresses      = "10.1.1.212"
  log               = false
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
  to_addresses      = "10.1.1.201"
  log               = false
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
  to_addresses      = "10.1.1.215"
  log               = false
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
  to_addresses      = "10.1.1.216"
  log               = false
}

resource "routeros_ip_firewall_nat" "ntp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - Redirect all NTP to local"
  disabled          = false
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.lan.name
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
  in_interface_list = routeros_interface_list.lan.name
  dst_port          = 53
  to_addresses      = "10.17.1.1"
  log               = false
}


# ================================================================================================
# FIREWALL Filter
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_filter
# ================================================================================================
resource "routeros_ip_firewall_filter" "input_accept_from_wireguard" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - allow WireGuard traffic (already allowed by adding it to LAN list)"
  action      = "accept"
  chain       = "input"
  disabled    = true
  src_address = "10.17.100.0/24"
}

resource "routeros_ip_firewall_filter" "input_accept_wireguard" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - allow WireGuard"
  action   = "accept"
  chain    = "input"
  dst_port = "13231"
  protocol = "udp"
}

resource "routeros_ip_firewall_filter" "input_accept_established" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - accept established, related, untracked"
  action           = "accept"
  chain            = "input"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "input_drop_invalid" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - drop invalid"
  action           = "drop"
  chain            = "input"
  connection_state = "invalid"
}

resource "routeros_ip_firewall_filter" "input_accept_icmp" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ICMP"
  action   = "accept"
  chain    = "input"
  protocol = "icmp"
}

resource "routeros_ip_firewall_filter" "input_accept_to_loopback" {
  provider    = routeros.rb5009
  comment     = "defconf - Managed by Terraform - accept to local loopback (for CAPsMAN)"
  action      = "accept"
  chain       = "input"
  dst_address = "127.0.0.1"
}

resource "routeros_ip_firewall_filter" "input_drop_not_lan" {
  provider          = routeros.rb5009
  comment           = "defconf - Managed by Terraform - drop all not coming from LAN"
  action            = "drop"
  chain             = "input"
  disabled          = false
  in_interface_list = "!${routeros_interface_list.lan.name}"
  log               = false
}

resource "routeros_ip_firewall_filter" "forward_accept_in_ipsec" {
  provider     = routeros.rb5009
  comment      = "defconf - Managed by Terraform - accept in ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "in,ipsec"
}

resource "routeros_ip_firewall_filter" "forward_accept_out_ipsec" {
  provider     = routeros.rb5009
  comment      = "defconf - Managed by Terraform - accept out ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "out,ipsec"
}

resource "routeros_ip_firewall_filter" "forward_fasttrack" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - fasttrack"
  action           = "fasttrack-connection"
  chain            = "forward"
  connection_state = "established,related"
  hw_offload       = true
}

resource "routeros_ip_firewall_filter" "forward_accept_established" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - accept established,related, untracked"
  action           = "accept"
  chain            = "forward"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "forward_drop_invalid" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - drop invalid except returning from BGP network"
  action           = "drop"
  chain            = "forward"
  connection_state = "invalid"
  dst_address      = "!10.1.1.0/24"
}

resource "routeros_ip_firewall_filter" "forward_drop_wan_not_dstnatted" {
  provider             = routeros.rb5009
  comment              = "defconf - Managed by Terraform - drop all from WAN not DSTNATed"
  action               = "drop"
  chain                = "forward"
  connection_nat_state = "!dstnat"
  connection_state     = "new"
  in_interface_list    = routeros_interface_list.wan.name
}

resource "routeros_ip_firewall_filter" "forward_drop_smarttv_to_wan" {
  provider           = routeros.rb5009
  comment            = "Managed by Terraform - Drop SmartTV to WAN"
  action             = "drop"
  chain              = "forward"
  src_address        = routeros_ip_dhcp_server_lease.tv.address
  out_interface_list = routeros_interface_list.wan.name
}

resource "routeros_ip_firewall_filter" "allow_vpn_exit_vlan_forward" {
  provider      = routeros.rb5009
  comment       = "Managed by Terraform - Allow VPN VLAN to WireGuard"
  chain         = "forward"
  src_address   = routeros_ip_dhcp_server_network.vpn_exit.address
  out_interface = routeros_interface_wireguard.vpn_exit.name
  action        = "accept"
}


# ================================================================================================
# NAT-PMP
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_nat_pmp
# ================================================================================================
resource "routeros_ip_nat_pmp" "nat_pmp" {
  provider = routeros.rb5009
  enabled  = true
}
# ================================================================================================
# NAT-PMP Interfaces
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_nat_pmp_interfaces
# ================================================================================================
resource "routeros_ip_nat_pmp_interfaces" "wireguard_vpn_exit" {
  provider  = routeros.rb5009
  interface = routeros_interface_wireguard.vpn_exit.name
  type      = "external"
}
resource "routeros_ip_nat_pmp_interfaces" "vlan_vpn_exit" {
  provider  = routeros.rb5009
  interface = routeros_interface_vlan.vpn_exit.name
  type      = "internal"
}
