resource "routeros_ipv6_settings" "settings" {
  provider     = routeros.hap_ac2
  disable_ipv6 = false
}

# https://www.reddit.com/r/mikrotik/comments/16410a1/comment/jy8tl37/

# This shouldn't actually be needed in terraform, it's the default rule that can't be removed
resource "routeros_ipv6_neighbor_discovery" "default" {
  provider  = routeros.hap_ac2
  disabled  = false
  comment   = "Managed by Terraform"
  interface = "all"
}

resource "routeros_ipv6_address" "main" {
  provider        = routeros.hap_ac2
  comment         = "Managed by Terraform"
  address         = "fd2f::1/64"
  interface       = routeros_interface_vlan.main.name
  advertise       = "true"
  auto_link_local = "true"
}

resource "routeros_ipv6_firewall_addr_list" "site_local" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - site-local"
  address  = "fec0::/10"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "unspecified_address" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - unspecified address"
  address  = "::/128"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "discard_only" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - discard only "
  address  = "100::/64"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "ipv4_mapped" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - ipv4-mapped"
  address  = "::ffff:0.0.0.0/96"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "sixbone" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - 6bone"
  address  = "3ffe::/16"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "orchid" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - ORCHID"
  address  = "2001:10::/28"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "documentation" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - documentation"
  address  = "2001:db8::/32"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "ipv4_compat" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - ipv4 compat"
  address  = "::/96"
  list     = local.addr_list_bad_ipv6
}

resource "routeros_ipv6_firewall_addr_list" "loopback" {
  provider = routeros.hap_ac2
  comment  = "defconf - Managed by Terraform - lo"
  address  = "::1/128"
  list     = local.addr_list_bad_ipv6
}
