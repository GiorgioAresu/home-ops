# ================================================================================================
# FIREWALL NAT
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_nat
# ================================================================================================
resource "routeros_ip_firewall_nat" "wan" {
  provider           = routeros.hap_ac2
  comment            = "Managed by Terraform - WAN masquerade"
  chain              = "srcnat"
  action             = "masquerade"
  out_interface_list = routeros_interface_list.wan.name
  log                = false
}

# Add HASS
# resource "routeros_ip_firewall_nat" "ingress" {
#   provider          = routeros.hap_ac2
#   comment           = "Managed by Terraform - HASS"
#   disabled          = false
#   action            = "dst-nat"
#   chain             = "dstnat"
#   protocol          = "tcp"
#   in_interface_list = routeros_interface_list.wan.name
#   dst_port          = 443
#   to_addresses      = "192.168.1.30"
#   log               = false
# }

resource "routeros_ip_firewall_nat" "ntp" {
  provider          = routeros.hap_ac2
  comment           = "Managed by Terraform - Redirect all NTP to local"
  disabled          = false
  action            = "redirect"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.lan.name
  dst_port          = 123
  to_ports          = "123"
  log               = false
}

resource "routeros_ip_firewall_nat" "dns_tcp" {
  provider          = routeros.hap_ac2
  comment           = "Managed by Terraform - Redirect all DNS to local"
  disabled          = true
  action            = "redirect"
  chain             = "dstnat"
  protocol          = "tcp"
  in_interface_list = routeros_interface_list.lan.name
  dst_port          = 53
  to_ports          = "53"
  log               = false
}

resource "routeros_ip_firewall_nat" "dns_udp" {
  provider          = routeros.hap_ac2
  comment           = "Managed by Terraform - Redirect all DNS to local"
  disabled          = true
  action            = "redirect"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.lan.name
  dst_port          = 53
  to_ports          = "53"
  log               = false
}


# ================================================================================================
# FIREWALL Filter
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_filter
# ================================================================================================
resource "routeros_ip_firewall_filter" "input_accept_from_wireguard" {
  provider    = routeros.hap_ac2
  comment     = "Managed by Terraform - allow WireGuard traffic (already allowed by adding it to LAN list)"
  action      = "accept"
  chain       = "input"
  disabled    = true
  src_address = "10.17.100.0/24"
}

resource "routeros_ip_firewall_filter" "input_accept_wireguard" {
  provider = routeros.hap_ac2
  comment  = "Managed by Terraform - allow WireGuard"
  action   = "accept"
  chain    = "input"
  dst_port = "13231"
  protocol = "udp"
}

resource "routeros_ip_firewall_filter" "input_accept_established" {
  provider         = routeros.hap_ac2
  comment          = "defconf - Managed by Terraform - accept established, related, untracked"
  action           = "accept"
  chain            = "input"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "input_drop_invalid" {
  provider         = routeros.hap_ac2
  comment          = "defconf - Managed by Terraform - drop invalid"
  action           = "drop"
  chain            = "input"
  connection_state = "invalid"
}

resource "routeros_ip_firewall_filter" "input_accept_icmp" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - accept ICMP"
  action   = "accept"
  chain    = "input"
  protocol = "icmp"
}

resource "routeros_ip_firewall_filter" "input_accept_to_loopback" {
  provider    = routeros.hap_ac2
  comment     = "defconf - Managed by Terraform - accept to local loopback (for CAPsMAN)"
  action      = "accept"
  chain       = "input"
  dst_address = "127.0.0.1"
}

resource "routeros_ip_firewall_filter" "input_drop_not_lan" {
  provider          = routeros.hap_ac2
  comment           = "defconf - Managed by Terraform - drop all not coming from LAN"
  action            = "drop"
  chain             = "input"
  disabled          = false
  in_interface_list = "!${routeros_interface_list.lan.name}"
  log               = false
}

resource "routeros_ip_firewall_filter" "forward_accept_in_ipsec" {
  provider     = routeros.hap_ac2
  comment      = "defconf - Managed by Terraform - accept in ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "in,ipsec"
}

resource "routeros_ip_firewall_filter" "forward_accept_out_ipsec" {
  provider     = routeros.hap_ac2
  comment      = "defconf - Managed by Terraform - accept out ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "out,ipsec"
}

resource "routeros_ip_firewall_filter" "forward_fasttrack" {
  provider         = routeros.hap_ac2
  comment          = "defconf - Managed by Terraform - fasttrack"
  action           = "fasttrack-connection"
  chain            = "forward"
  connection_state = "established,related"
  hw_offload       = true
}

resource "routeros_ip_firewall_filter" "forward_accept_established" {
  provider         = routeros.hap_ac2
  comment          = "defconf - Managed by Terraform - accept established,related, untracked"
  action           = "accept"
  chain            = "forward"
  connection_state = "established,related,untracked"
}

resource "routeros_ip_firewall_filter" "forward_drop_invalid" {
  provider         = routeros.hap_ac2
  comment          = "defconf - Managed by Terraform - drop invalid except returning from BGP network"
  action           = "drop"
  chain            = "forward"
  connection_state = "invalid"
  dst_address      = "!10.1.1.0/24"
}

resource "routeros_ip_firewall_filter" "forward_drop_wan_not_dstnatted" {
  provider             = routeros.hap_ac2
  comment              = "defconf - Managed by Terraform - drop all from WAN not DSTNATed"
  action               = "drop"
  chain                = "forward"
  connection_nat_state = "!dstnat"
  connection_state     = "new"
  in_interface_list    = routeros_interface_list.wan.name
}
