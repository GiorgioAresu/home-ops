resource "routeros_interface_vlan" "hAP_ax3_guest" {
  provider  = routeros.hAP_ax3
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.hAP_ax3_bridge.name
  name      = "Guest"
  vlan_id   = local.vlan_id_guest
}
resource "routeros_interface_vlan" "hAP_ax3_iot" {
  provider  = routeros.hAP_ax3
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.hAP_ax3_bridge.name
  name      = "IoT"
  vlan_id   = local.vlan_id_iot
}
resource "routeros_interface_vlan" "hAP_ax_lite_LTE6_guest" {
  provider  = routeros.hAP_ax_lite_LTE6
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  name      = "Guest"
  vlan_id   = local.vlan_id_guest
}
resource "routeros_interface_vlan" "hAP_ax_lite_LTE6_iot" {
  provider  = routeros.hAP_ax_lite_LTE6
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  name      = "IoT"
  vlan_id   = local.vlan_id_iot
}

resource "routeros_interface_bridge_vlan" "hAP_ax3_guest" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.hAP_ax3_bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
  tagged   = ["ether1"]
}
resource "routeros_interface_bridge_vlan" "hAP_ax3_iot" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.hAP_ax3_bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
  tagged   = ["ether1"]
}
resource "routeros_interface_bridge_vlan" "hAP_ax_lite_LTE6_guest" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
  tagged   = ["ether1"]
}
resource "routeros_interface_bridge_vlan" "hAP_ax_lite_LTE6_iot" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
  tagged   = ["ether1"]
}
