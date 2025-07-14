resource "routeros_interface_bridge" "travel_bridge" {
  comment        = "defconf - Managed by Terraform"
  name           = "bridge"
  vlan_filtering = false
}
# =================================================================================================
# Bridge Ports
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge_port
# =================================================================================================
resource "routeros_interface_bridge_port" "ether2" {
  bridge    = routeros_interface_bridge.travel_bridge.name
  interface = "ether2"
  comment   = "Managed by Terraform"
}
resource "routeros_interface_bridge_port" "ether3" {
  bridge    = routeros_interface_bridge.travel_bridge.name
  interface = "ether3"
  comment   = "Managed by Terraform"
}
resource "routeros_interface_bridge_port" "ether4" {
  bridge    = routeros_interface_bridge.travel_bridge.name
  interface = "ether4"
  comment   = "Managed by Terraform"
}

resource "routeros_interface_list" "travel_lan" {
  comment = "Managed by Terraform"
  name    = "LAN"
}
resource "routeros_interface_list" "travel_wan" {
  comment = "Managed by Terraform"
  name    = "WAN"
}

resource "routeros_interface_list_member" "travel_lan_bridge" {
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.travel_bridge.name
  list      = routeros_interface_list.travel_lan.name
}
resource "routeros_interface_list_member" "travel_wan_bridgewan" {
  comment   = "Managed by Terraform"
  interface = "bridge1" # TODO: replace
  list      = routeros_interface_list.travel_wan.name
}
