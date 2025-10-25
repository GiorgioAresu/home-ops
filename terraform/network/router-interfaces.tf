# =================================================================================================
# INTERFACE Ethernet
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_ethernet
# =================================================================================================
resource "routeros_interface_ethernet" "rb5009_ether1" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - WAN DSL Uplink"
  factory_name = "ether1"
  name         = "ether1"
}
resource "routeros_interface_ethernet" "rb5009_ether2" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - [PRAN] hAP ax3"
  factory_name = "ether2"
  name         = "ether2"
}
resource "routeros_interface_ethernet" "rb5009_ether3" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - [GI A] Unifi UAP AC Lite"
  factory_name = "ether3"
  name         = "ether3"
}
resource "routeros_interface_ethernet" "rb5009_ether4" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - [SA B] hAP ax lite LTE"
  factory_name = "ether4"
  name         = "ether4"
}
resource "routeros_interface_ethernet" "rb5009_ether5" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - HomeAssistant Blue"
  factory_name = "ether5"
  name         = "ether5"
}
resource "routeros_interface_ethernet" "rb5009_ether6" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - JetKVM"
  factory_name = "ether6"
  name         = "ether6"
}
resource "routeros_interface_ethernet" "rb5009_ether7" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - Unmanaged TP-Link"
  factory_name = "ether7"
  name         = "ether7"
}
resource "routeros_interface_ethernet" "rb5009_ether8" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform - Unmanaged Netgear"
  factory_name = "ether8"
  name         = "ether8"
}
resource "routeros_interface_ethernet" "rb5009_sfp_sfpplus1" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  factory_name = "sfp-sfpplus1"
  name         = "sfp-sfpplus1"
}


# =================================================================================================
# INTERFACE Bridge
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "bridge" {
  provider       = routeros.rb5009
  comment        = "Managed by Terraform"
  name           = "bridge"
  vlan_filtering = true
}


# =================================================================================================
# INTERFACE Bridge Ports
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge_port
# =================================================================================================
resource "routeros_interface_bridge_port" "rb5009_ether2" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether2.name
  pvid        = "1"
  frame_types = "admit-all"
}
resource "routeros_interface_bridge_port" "rb5009_ether3" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether3.name
  pvid        = "1"
  frame_types = "admit-all"
}
resource "routeros_interface_bridge_port" "rb5009_ether4" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether4.name
  pvid        = routeros_interface_vlan.guest.vlan_id
  frame_types = "admit-only-untagged-and-priority-tagged"
}
resource "routeros_interface_bridge_port" "rb5009_ether5" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether5.name
  pvid        = "1"
  frame_types = "admit-all"
}
resource "routeros_interface_bridge_port" "rb5009_ether6" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether6.name
  pvid        = "1"
  frame_types = "admit-all"
}
resource "routeros_interface_bridge_port" "rb5009_ether7" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether7.name
  pvid        = "1"
  frame_types = "admit-all"
}
resource "routeros_interface_bridge_port" "rb5009_ether8" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.bridge.name
  interface   = routeros_interface_ethernet.rb5009_ether8.name
  pvid        = "1"
  frame_types = "admit-all"
}

# =================================================================================================
# INTERFACE List
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_list
# =================================================================================================
resource "routeros_interface_list" "lan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "LAN"
}
resource "routeros_interface_list" "wan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "WAN"
}


# =================================================================================================
# INTERFACE List Member
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_list_member
# =================================================================================================
resource "routeros_interface_list_member" "lan_bridge" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_bridge.bridge.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "lan_guest" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.guest.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "lan_iot" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.iot.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "lan_security" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.security.name
  list      = routeros_interface_list.lan.name
}
resource "routeros_interface_list_member" "wan_fttc" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_ethernet.rb5009_ether1.name
  list      = routeros_interface_list.wan.name
}
resource "routeros_interface_list_member" "wan_lte" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  interface = routeros_interface_vlan.router_wan_backup.name
  list      = routeros_interface_list.wan.name
}
