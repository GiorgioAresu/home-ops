# =================================================================================================
# INTERFACE Ethernet
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_ethernet
# =================================================================================================
resource "routeros_interface_ethernet" "ether1" {
  comment      = "Managed by Terraform"
  factory_name = "ether1"
  name         = "ether1"
}
resource "routeros_interface_ethernet" "ether2" {
  comment      = "Managed by Terraform"
  factory_name = "ether2"
  name         = "ether2"
}
resource "routeros_interface_ethernet" "ether3" {
  comment      = "Managed by Terraform"
  factory_name = "ether3"
  name         = "ether3"
}
resource "routeros_interface_ethernet" "ether4" {
  comment      = "Managed by Terraform"
  factory_name = "ether4"
  name         = "ether4"
}


# =================================================================================================
# INTERFACE Bridge
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "bridge" {
  comment        = "defconf - Managed by Terraform"
  name           = "bridge"
  vlan_filtering = false
}


# =================================================================================================
# INTERFACE Bridge Ports
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge_port
# =================================================================================================
resource "routeros_interface_bridge_port" "ether2" {
  bridge    = routeros_interface_bridge.bridge.name
  interface = routeros_interface_ethernet.ether2.name
  comment   = "Managed by Terraform"
}
resource "routeros_interface_bridge_port" "ether3" {
  bridge    = routeros_interface_bridge.bridge.name
  interface = routeros_interface_ethernet.ether3.name
  comment   = "Managed by Terraform"
}
resource "routeros_interface_bridge_port" "ether4" {
  bridge    = routeros_interface_bridge.bridge.name
  interface = routeros_interface_ethernet.ether4.name
  comment   = "Managed by Terraform"
}


# =================================================================================================
# INTERFACE List
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_list
# =================================================================================================
resource "routeros_interface_list" "lan" {
  comment = "Managed by Terraform"
  name    = "LAN"
}
resource "routeros_interface_list" "wan" {
  comment = "Managed by Terraform"
  name    = "WAN"
}


# =================================================================================================
# INTERFACE List Member
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_list_member
# =================================================================================================
resource "routeros_interface_list_member" "lan_bridge" {
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "wan_ether1" {
  comment   = "Managed by Terraform"
  interface = routeros_interface_ethernet.ether1.name
  list      = routeros_interface_list.wan.name
}
