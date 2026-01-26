resource "routeros_interface_vlan" "hAP_ax3_guest" {
  provider  = routeros.hAP_ax3
  comment   = "Managed by Terraform - Guest"
  interface = routeros_interface_bridge.hAP_ax3_bridge.name
  name      = "Guest"
  vlan_id   = local.vlan_id_guest
}
resource "routeros_interface_vlan" "hAP_ax3_iot" {
  provider  = routeros.hAP_ax3
  comment   = "Managed by Terraform - IoT"
  interface = routeros_interface_bridge.hAP_ax3_bridge.name
  name      = "IoT"
  vlan_id   = local.vlan_id_iot
}
resource "routeros_interface_vlan" "hAP_ax_lite_LTE6_guest" {
  provider  = routeros.hAP_ax_lite_LTE6
  comment   = "Managed by Terraform - Guest"
  interface = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  name      = "Guest"
  vlan_id   = local.vlan_id_guest
}
resource "routeros_interface_vlan" "hAP_ax_lite_LTE6_iot" {
  provider  = routeros.hAP_ax_lite_LTE6
  comment   = "Managed by Terraform - IoT"
  interface = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  name      = "IoT"
  vlan_id   = local.vlan_id_iot
}

resource "routeros_interface_bridge_vlan" "hAP_ax3_lan" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform - LAN"
  bridge   = routeros_interface_bridge.hAP_ax3_bridge.name
  vlan_ids = [1]
  tagged   = []
  untagged = [
    routeros_interface_bridge.hAP_ax3_bridge.name,
    "ether1",
    "ether2",
    "ether3",
    "ether4",
    "ether5",
  ]
}
resource "routeros_interface_bridge_vlan" "hAP_ax3_guest" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform - Guest"
  bridge   = routeros_interface_bridge.hAP_ax3_bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
  tagged   = [routeros_interface_bridge.hAP_ax3_bridge.name, "ether1"]
}
resource "routeros_interface_bridge_vlan" "hAP_ax3_iot" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform - IoT"
  bridge   = routeros_interface_bridge.hAP_ax3_bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
  tagged   = [routeros_interface_bridge.hAP_ax3_bridge.name, "ether1"]
}

resource "routeros_interface_bridge_vlan" "hAP_ax_lite_LTE6_lan" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform - LAN"
  bridge   = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  vlan_ids = [1]
  tagged   = []
  untagged = [
    routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name,
    "ether1",
    "ether2",
    "ether3",
    "ether4",
  ]
}
resource "routeros_interface_bridge_vlan" "hAP_ax_lite_LTE6_guest" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform - Guest"
  bridge   = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
  tagged   = [routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name, "ether1"]
}
resource "routeros_interface_bridge_vlan" "hAP_ax_lite_LTE6_iot" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform - IoT"
  bridge   = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
  tagged   = [routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name, "ether1"]
}
