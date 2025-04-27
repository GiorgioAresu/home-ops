resource "routeros_interface_list" "lan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name = "LAN"
}
resource "routeros_interface_list" "wan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name = "WAN"
}

resource "routeros_interface_list_member" "lan_bridge" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  interface = "bridge"
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "wan_bridgewan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  interface = "bridge_wan"
  list      = routeros_interface_list.wan.name
}

