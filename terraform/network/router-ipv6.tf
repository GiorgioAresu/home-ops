resource "routeros_ipv6_settings" "settings" {
  provider     = routeros.rb5009
  disable_ipv6 = false
}

# https://www.reddit.com/r/mikrotik/comments/16410a1/comment/jy8tl37/

# This shouldn't actually be needed in terraform, it's the default rule that can't be removed
resource "routeros_ipv6_neighbor_discovery" "default" {
  provider      = routeros.rb5009
  comment       = "Managed by Terraform"
  interface     = "all"
}

resource "routeros_ipv6_neighbor_discovery" "iot" {
  provider      = routeros.rb5009
  comment       = "Managed by Terraform"
  interface     = routeros_interface_vlan.iot.name
  dns           = "fd2f::1"
  advertise_dns = true
}

resource "routeros_ipv6_address" "iot" {
  provider        = routeros.rb5009
  comment         = "Managed by Terraform"
  address         = "fd2f::1/64"
  interface       = routeros_interface_vlan.iot.name
  advertise       = "true"
  auto_link_local = "true"
}
