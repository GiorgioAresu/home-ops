# =================================================================================================
# Bridge Interfaces
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "bridge" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform"
  name              = "bridge"
  vlan_filtering    = true
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
resource "routeros_interface_list_member" "lan_guest" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.guest.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "lan_iot" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.iot.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "lan_security" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.security.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "wan_fttc" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = "ether1"
  list      = routeros_interface_list.wan.name
}
resource "routeros_interface_list_member" "wan_lte" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.router_wan_backup.name
  list      = routeros_interface_list.wan.name
}
