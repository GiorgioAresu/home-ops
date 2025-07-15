# =================================================================================================
# Bridge Interfaces
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "bridge" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform"
  name              = "bridge"
  vlan_filtering    = true
  ingress_filtering = false # TODO: Enable this at some point
}


resource "routeros_interface_list" "lan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "LAN"
}
resource "routeros_interface_list" "wan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "WAN"
}


resource "routeros_interface_list_member" "lan_bridge" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "guest_bridge" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.guest.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "iot_bridge" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.iot.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "security_bridge" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.security.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "wan_bridgewan" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = "bridge_wan" # TODO: replace
  list      = routeros_interface_list.wan.name
}
resource "routeros_interface_list_member" "wan_bridgelte" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.router_wan_backup.name
  list      = routeros_interface_list.wan.name
}
