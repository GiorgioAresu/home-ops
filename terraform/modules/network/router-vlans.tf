resource "routeros_interface_vlan" "guest" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "Guest"
  vlan_id   = local.vlan_id_guest
}
resource "routeros_interface_vlan" "security" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "Security"
  vlan_id   = local.vlan_id_security
}
resource "routeros_interface_vlan" "iot" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "IoT"
  vlan_id   = local.vlan_id_iot
}
resource "routeros_interface_vlan" "router_wan_backup" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "lte"
  vlan_id   = local.vlan_id_wan_backup
}
resource "unifi_network" "guest" {
  name    = "guest"
  purpose = "vlan-only"
  vlan_id = local.vlan_id_guest
}
resource "unifi_network" "security" {
  name    = "security"
  purpose = "vlan-only"
  vlan_id = local.vlan_id_security
}
resource "unifi_network" "iot" {
  name    = "iot"
  purpose = "vlan-only"
  vlan_id = local.vlan_id_iot
}

resource "routeros_interface_bridge_vlan" "guest" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, "ether2", "ether7", "ether8"]
  untagged = ["ether4"] # SA A
}
resource "routeros_interface_bridge_vlan" "security" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.security.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, "ether2", "ether5", "ether7", "ether8"] # 2 hap ax3, 3 hap ax lite LTE, 5 hass, 7-8 unmanaged switches
}
resource "routeros_interface_bridge_vlan" "iot" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, "ether2", "ether5", "ether7", "ether8"]
}
resource "routeros_interface_bridge_vlan" "router_wan_backup" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.router_wan_backup.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, "ether8"]
}
