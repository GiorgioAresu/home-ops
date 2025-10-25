resource "routeros_interface_vlan" "guest" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform - Guest"
  interface = routeros_interface_bridge.bridge.name
  name      = "Guest"
  vlan_id   = local.vlan_id_guest
}
resource "routeros_interface_vlan" "security" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform - Security"
  interface = routeros_interface_bridge.bridge.name
  name      = "Security"
  vlan_id   = local.vlan_id_security
}
resource "routeros_interface_vlan" "iot" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform - IoT"
  interface = routeros_interface_bridge.bridge.name
  name      = "IoT"
  vlan_id   = local.vlan_id_iot
}
resource "routeros_interface_vlan" "router_wan_backup" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform - WAN backup"
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
  name          = "security"
  multicast_dns = true
  purpose       = "vlan-only"
  vlan_id       = local.vlan_id_security
}
resource "unifi_network" "iot" {
  name          = "iot"
  multicast_dns = true
  purpose       = "vlan-only"
  vlan_id       = local.vlan_id_iot
}

resource "routeros_interface_bridge_vlan" "guest" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, routeros_interface_ethernet.rb5009_ether2.name, routeros_interface_ethernet.rb5009_ether3.name, routeros_interface_ethernet.rb5009_ether7.name, routeros_interface_ethernet.rb5009_ether8.name]
  untagged = [routeros_interface_ethernet.rb5009_ether4.name]
}
resource "routeros_interface_bridge_vlan" "security" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.security.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, routeros_interface_ethernet.rb5009_ether2.name, routeros_interface_ethernet.rb5009_ether3.name, routeros_interface_ethernet.rb5009_ether5.name, routeros_interface_ethernet.rb5009_ether7.name, routeros_interface_ethernet.rb5009_ether8.name]
}
resource "routeros_interface_bridge_vlan" "iot" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, routeros_interface_ethernet.rb5009_ether2.name, routeros_interface_ethernet.rb5009_ether3.name, routeros_interface_ethernet.rb5009_ether5.name, routeros_interface_ethernet.rb5009_ether7.name, routeros_interface_ethernet.rb5009_ether8.name]
}
resource "routeros_interface_bridge_vlan" "router_wan_backup" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.router_wan_backup.vlan_id]
  tagged   = [routeros_interface_bridge.bridge.name, routeros_interface_ethernet.rb5009_ether8.name]
}
