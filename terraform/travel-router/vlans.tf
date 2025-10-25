# resource "routeros_interface_vlan" "home" {
#   comment   = "Managed by Terraform"
#   interface = routeros_interface_bridge.bridge_lan.name
#   name      = "vlan-home"
#   vlan_id   = local.vlan_id_home
# }
# resource "routeros_interface_bridge_vlan" "home" {
#   comment  = "Managed by Terraform"
#   bridge   = routeros_interface_bridge.bridge_lan.name
#   vlan_ids = [routeros_interface_vlan.home.vlan_id]
#   tagged   = [routeros_interface_bridge.bridge_lan.name]
#   untagged = [routeros_interface_wireguard.travel.name, routeros_interface_wireless.home.name]
# }
