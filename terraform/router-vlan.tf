resource "routeros_interface_vlan" "iot" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = "bridge"
  name      = "IoT"
  vlan_id   = 50
}
resource "routeros_interface_vlan" "security" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = "bridge"
  name      = "Security"
  vlan_id   = 40
}
resource "routeros_interface_vlan" "guest" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = "bridge"
  name      = "Guest"
  vlan_id   = 30
}
