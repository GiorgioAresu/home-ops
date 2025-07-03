resource "routeros_interface_vlan" "guest" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "Guest"
  vlan_id   = 30
}
resource "routeros_interface_vlan" "security" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "Security"
  vlan_id   = 40
}
resource "routeros_interface_vlan" "iot" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "IoT"
  vlan_id   = 50
}
resource "routeros_interface_vlan" "router_wan_backup" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  name      = "lte"
  vlan_id   = 2
}

resource "routeros_interface_bridge_vlan" "guest" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.guest.vlan_id]
}
resource "routeros_interface_bridge_vlan" "security" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.security.vlan_id]
}
resource "routeros_interface_bridge_vlan" "iot" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.iot.vlan_id]
}
resource "routeros_interface_bridge_vlan" "router_wan_backup" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_ids = [routeros_interface_vlan.router_wan_backup.vlan_id]
}
