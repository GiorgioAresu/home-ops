resource "routeros_ipv6_firewall_filter" "input_accept_established" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - accept established,related,untracked"
  action           = "accept"
  chain            = "input"
  connection_state = "established,related,untracked"
}

resource "routeros_ipv6_firewall_filter" "input_drop_invalid" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - drop invalid"
  action           = "drop"
  chain            = "input"
  connection_state = "invalid"
}

resource "routeros_ipv6_firewall_filter" "input_accept_icmpv6" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ICMPv6"
  action   = "accept"
  chain    = "input"
  protocol = "icmpv6"
}

resource "routeros_ipv6_firewall_filter" "input_accept_udp_traceroute" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept UDP traceroute"
  action   = "accept"
  chain    = "input"
  protocol = "udp"
  dst_port = "33434-33534"
}

resource "routeros_ipv6_firewall_filter" "input_accept_dhcpv6_client_prefix_delegation" {
  provider    = routeros.rb5009
  comment     = "defconf - Managed by Terraform - accept DHCPv6-Client prefix delegation"
  action      = "accept"
  chain       = "input"
  protocol    = "udp"
  dst_port    = "546"
  src_address = "fe80::/10"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ike" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept IKE"
  action   = "accept"
  chain    = "input"
  protocol = "udp"
  dst_port = "500,4500"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ipsec_ah" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ipsec AH"
  action   = "accept"
  chain    = "input"
  protocol = "ipsec-ah"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ipsec_esp" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ipsec ESP"
  action   = "accept"
  chain    = "input"
  protocol = "ipsec-esp"
}

resource "routeros_ipv6_firewall_filter" "input_accept_ipsec_policy" {
  provider     = routeros.rb5009
  comment      = "defconf - Managed by Terraform - accept all that matches ipsec policy"
  action       = "accept"
  chain        = "input"
  ipsec_policy = "in,ipsec"
}

resource "routeros_ipv6_firewall_filter" "input_drop_not_lan" {
  provider          = routeros.rb5009
  comment           = "defconf - Managed by Terraform - drop everything else not coming from LAN"
  action            = "drop"
  chain             = "input"
  in_interface_list = "!${routeros_interface_list.lan.name}"
}

resource "routeros_ipv6_firewall_filter" "forward_fasttrack" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - fasttrack6"
  action           = "fasttrack-connection"
  chain            = "forward"
  connection_state = "established,related"
  place_before = routeros_ipv6_firewall_filter.forward_accept_established.id
}

resource "routeros_ipv6_firewall_filter" "forward_accept_established" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - accept established,related,untracked"
  action           = "accept"
  chain            = "forward"
  connection_state = "established,related,untracked"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_invalid" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - drop invalid"
  action           = "drop"
  chain            = "forward"
  connection_state = "invalid"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_bad_ipv6_src" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - drop packets with bad src ipv6"
  action           = "drop"
  chain            = "forward"
  src_address_list = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_filter" "forward_drop_bad_ipv6_dst" {
  provider         = routeros.rb5009
  comment          = "defconf - Managed by Terraform - drop packets with bad dst ipv6"
  action           = "drop"
  chain            = "forward"
  dst_address_list = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_filter" "forward_drop_hop_limit" {
  provider  = routeros.rb5009
  comment   = "defconf - Managed by Terraform - rfc4890 drop hop-limit=1"
  action    = "drop"
  chain     = "forward"
  protocol  = "icmpv6"
  hop_limit = "equal:1"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_icmpv6" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ICMPv6"
  action   = "accept"
  chain    = "forward"
  protocol = "icmpv6"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_hip" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept HIP"
  action   = "accept"
  chain    = "forward"
  protocol = "139"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ike" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept IKE"
  action   = "accept"
  chain    = "forward"
  protocol = "udp"
  dst_port = "500,4500"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ipsec_ah" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ipsec AH"
  action   = "accept"
  chain    = "forward"
  protocol = "ipsec-ah"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ipsec_esp" {
  provider = routeros.rb5009
  comment  = "defconf - Managed by Terraform - accept ipsec ESP"
  action   = "accept"
  chain    = "forward"
  protocol = "ipsec-esp"
}

resource "routeros_ipv6_firewall_filter" "forward_accept_ipsec_policy" {
  provider     = routeros.rb5009
  comment      = "defconf - Managed by Terraform - accept all that matches ipsec policy"
  action       = "accept"
  chain        = "forward"
  ipsec_policy = "in,ipsec"
}

resource "routeros_ipv6_firewall_filter" "forward_drop_not_lan" {
  provider          = routeros.rb5009
  comment           = "defconf - Managed by Terraform - drop everything else not coming from LAN"
  action            = "drop"
  chain             = "forward"
  in_interface_list = "!${routeros_interface_list.lan.name}"
}




import {
  to = routeros_ipv6_firewall_filter.input_accept_established
  id = "*17"
}
import {
  to = routeros_ipv6_firewall_filter.input_drop_invalid
  id = "*18"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_icmpv6
  id = "*19"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_udp_traceroute
  id = "*1A"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_dhcpv6_client_prefix_delegation
  id = "*1B"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_ike
  id = "*1C"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_ipsec_ah
  id = "*1D"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_ipsec_esp
  id = "*1E"
}
import {
  to = routeros_ipv6_firewall_filter.input_accept_ipsec_policy
  id = "*1F"
}
import {
  to = routeros_ipv6_firewall_filter.input_drop_not_lan
  id = "*20"
}

import {
  to = routeros_ipv6_firewall_filter.forward_accept_established
  id = "*21"
}
import {
  to = routeros_ipv6_firewall_filter.forward_drop_invalid
  id = "*22"
}
import {
  to = routeros_ipv6_firewall_filter.forward_drop_bad_ipv6_src
  id = "*23"
}
import {
  to = routeros_ipv6_firewall_filter.forward_drop_bad_ipv6_dst
  id = "*24"
}
import {
  to = routeros_ipv6_firewall_filter.forward_drop_hop_limit
  id = "*25"
}
import {
  to = routeros_ipv6_firewall_filter.forward_accept_icmpv6
  id = "*26"
}
import {
  to = routeros_ipv6_firewall_filter.forward_accept_hip
  id = "*27"
}
import {
  to = routeros_ipv6_firewall_filter.forward_accept_ike
  id = "*28"
}
import {
  to = routeros_ipv6_firewall_filter.forward_accept_ipsec_ah
  id = "*29"
}
import {
  to = routeros_ipv6_firewall_filter.forward_accept_ipsec_esp
  id = "*2A"
}
import {
  to = routeros_ipv6_firewall_filter.forward_accept_ipsec_policy
  id = "*2B"
}
import {
  to = routeros_ipv6_firewall_filter.forward_drop_not_lan
  id = "*2C"
}
