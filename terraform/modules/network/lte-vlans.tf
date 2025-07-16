resource "routeros_interface_vlan" "lte_lte" {
  provider  = routeros.hAP_ax_lite_LTE6
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.lte_bridge.name
  name      = "lte_passthrough"
  vlan_id   = 2
}

resource "routeros_interface_bridge_vlan" "lte_lte" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.lte_bridge.name
  vlan_ids = [routeros_interface_vlan.lte_lte.vlan_id]
  tagged   = [routeros_interface_bridge.lte_bridge.name, "ether1"]
}
