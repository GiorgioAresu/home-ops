# ================================================================================================
# FIREWALL NAT
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_nat
# ================================================================================================
resource "routeros_ip_firewall_nat" "wan" {
  comment            = "Managed by Terraform - WAN masquerade"
  chain              = "srcnat"
  action             = "masquerade"
  out_interface_list = routeros_interface_list.wan.name
}

resource "routeros_ip_firewall_nat" "dns" {
  comment           = "Managed by Terraform - Redirect all DNS to local"
  disabled          = true
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 53
  to_addresses      = "10.17.1.1"
}


# ================================================================================================
# FIREWALL Filter
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_firewall_filter
# ================================================================================================
# resource "routeros_ip_firewall_filter" "input_accept_wireguard" {
#   comment  = "Managed by Terraform - allow WireGuard"
#   action   = "accept"
#   chain    = "input"
#   dst_port = "13231"
#   protocol = "udp"
#   place_before = routeros_ip_firewall_filter.input_accept_established.id
# }

resource "routeros_ip_firewall_filter" "input_accept_established" {
  comment          = "defconf - Managed by Terraform - accept established, related, untracked"
  action           = "accept"
  chain            = "input"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.input_drop_invalid.id
}

resource "routeros_ip_firewall_filter" "input_drop_invalid" {
  comment          = "defconf - Managed by Terraform - drop invalid"
  action           = "drop"
  chain            = "input"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.input_accept_icmp.id
}

resource "routeros_ip_firewall_filter" "input_accept_icmp" {
  comment      = "defconf - Managed by Terraform - accept ICMP"
  action       = "accept"
  chain        = "input"
  protocol     = "icmp"
  place_before = routeros_ip_firewall_filter.input_drop_not_lan.id
}

resource "routeros_ip_firewall_filter" "input_drop_not_lan" {
  comment           = "defconf - Managed by Terraform - drop all not coming from LAN"
  action            = "drop"
  chain             = "input"
  disabled          = false
  in_interface_list = "!${routeros_interface_list.lan.name}"
  log               = false
  place_before      = routeros_ip_firewall_filter.forward_accept_in_ipsec.id
}

resource "routeros_ip_firewall_filter" "forward_accept_in_ipsec" {
  comment      = "defconf - Managed by Terraform - accept in ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "in,ipsec"
  place_before = routeros_ip_firewall_filter.forward_accept_out_ipsec.id
}

resource "routeros_ip_firewall_filter" "forward_accept_out_ipsec" {
  comment      = "defconf - Managed by Terraform - accept out ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "out,ipsec"
  place_before = routeros_ip_firewall_filter.forward_fasttrack.id
}

resource "routeros_ip_firewall_filter" "forward_fasttrack" {
  comment          = "defconf - Managed by Terraform - fasttrack"
  action           = "fasttrack-connection"
  chain            = "forward"
  connection_state = "established,related"
  hw_offload       = true
  place_before     = routeros_ip_firewall_filter.forward_accept_established.id
}

resource "routeros_ip_firewall_filter" "forward_accept_established" {
  comment          = "defconf - Managed by Terraform - accept established,related, untracked"
  action           = "accept"
  chain            = "forward"
  connection_state = "established,related,untracked"
  place_before     = routeros_ip_firewall_filter.forward_drop_invalid.id
}

resource "routeros_ip_firewall_filter" "forward_drop_invalid" {
  comment          = "defconf - Managed by Terraform - drop invalid"
  action           = "drop"
  chain            = "forward"
  connection_state = "invalid"
  place_before     = routeros_ip_firewall_filter.forward_drop_wan_not_dstnatted.id
}

resource "routeros_ip_firewall_filter" "forward_drop_wan_not_dstnatted" {
  comment              = "defconf - Managed by Terraform - drop all from WAN not DSTNATed"
  action               = "drop"
  chain                = "forward"
  connection_nat_state = "!dstnat"
  connection_state     = "new"
  in_interface_list    = routeros_interface_list.wan.name
}
