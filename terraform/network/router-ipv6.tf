resource "routeros_ipv6_settings" "settings" {
  provider     = routeros.rb5009
  disable_ipv6 = false
}

# https://www.reddit.com/r/mikrotik/comments/16410a1/comment/jy8tl37/

resource "routeros_ipv6_neighbor_discovery" "lan" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.iot.name
  dns       = "fd26::1"
}

