# =================================================================================================
# INTERFACE Ethernet
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_ethernet
# =================================================================================================
resource "routeros_interface_ethernet" "hAP_ax3_ether1" {
  provider     = routeros.hAP_ax3
  comment      = "Managed by Terraform - Uplink"
  factory_name = "ether1"
  name         = "ether1"
}
import {
  id = "default_name=ether1"
  to = routeros_interface_ethernet.hAP_ax3_ether1
}
resource "routeros_interface_ethernet" "hAP_ax3_ether2" {
  provider     = routeros.hAP_ax3
  comment      = "Managed by Terraform"
  factory_name = "ether2"
  name         = "ether2"
}
import {
  id = "default_name=ether2"
  to = routeros_interface_ethernet.hAP_ax3_ether2
}
resource "routeros_interface_ethernet" "hAP_ax3_ether3" {
  provider     = routeros.hAP_ax3
  comment      = "Managed by Terraform"
  factory_name = "ether3"
  name         = "ether3"
}
import {
  id = "default_name=ether3"
  to = routeros_interface_ethernet.hAP_ax3_ether3
}
resource "routeros_interface_ethernet" "hAP_ax3_ether4" {
  provider     = routeros.hAP_ax3
  comment      = "Managed by Terraform"
  factory_name = "ether4"
  name         = "ether4"
}
import {
  id = "default_name=ether4"
  to = routeros_interface_ethernet.hAP_ax3_ether4
}
resource "routeros_interface_ethernet" "hAP_ax3_ether5" {
  provider     = routeros.hAP_ax3
  comment      = "Managed by Terraform"
  factory_name = "ether5"
  name         = "ether5"
}
import {
  id = "default_name=ether5"
  to = routeros_interface_ethernet.hAP_ax3_ether5
}
resource "routeros_interface_ethernet" "hAP_ax_lite_LTE6_ether1" {
  provider     = routeros.hAP_ax_lite_LTE6
  comment      = "Managed by Terraform - Uplink"
  factory_name = "ether1"
  name         = "ether1"
}
import {
  id = "default_name=ether1"
  to = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether1
}
resource "routeros_interface_ethernet" "hAP_ax_lite_LTE6_ether2" {
  provider     = routeros.hAP_ax_lite_LTE6
  comment      = "Managed by Terraform"
  factory_name = "ether2"
  name         = "ether2"
}
import {
  id = "default_name=ether2"
  to = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether2
}
resource "routeros_interface_ethernet" "hAP_ax_lite_LTE6_ether3" {
  provider     = routeros.hAP_ax_lite_LTE6
  comment      = "Managed by Terraform"
  factory_name = "ether3"
  name         = "ether3"
}
import {
  id = "default_name=ether3"
  to = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether3
}
resource "routeros_interface_ethernet" "hAP_ax_lite_LTE6_ether4" {
  provider     = routeros.hAP_ax_lite_LTE6
  comment      = "Managed by Terraform"
  factory_name = "ether4"
  name         = "ether4"
}
import {
  id = "default_name=ether4"
  to = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether4
}
resource "routeros_interface_ethernet" "wAP_ax_ether1" {
  provider     = routeros.wAP_ax
  comment      = "Managed by Terraform - Uplink"
  factory_name = "ether1"
  name         = "ether1"
}
import {
  id = "default_name=ether1"
  to = routeros_interface_ethernet.wAP_ax_ether1
}
resource "routeros_interface_ethernet" "wAP_ax_ether2" {
  provider     = routeros.wAP_ax
  comment      = "Managed by Terraform"
  factory_name = "ether2"
  name         = "ether2"
}
import {
  id = "default_name=ether2"
  to = routeros_interface_ethernet.wAP_ax_ether2
}


# =================================================================================================
# INTERFACE Bridge
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "hAP_ax_lite_LTE6_bridge" {
  provider       = routeros.hAP_ax_lite_LTE6
  comment        = "defconf - Managed by Terraform"
  name           = "bridge"
  vlan_filtering = true
}
resource "routeros_interface_bridge" "hAP_ax3_bridge" {
  provider       = routeros.hAP_ax3
  comment        = "defconf - Managed by Terraform"
  name           = "bridgeLocal"
  vlan_filtering = true
}
resource "routeros_interface_bridge" "wAP_ax_bridge" {
  provider       = routeros.wAP_ax
  comment        = "defconf - Managed by Terraform"
  name           = "bridgeLocal"
  vlan_filtering = true
}


# =================================================================================================
# INTERFACE Bridge Ports
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge_port
# =================================================================================================
resource "routeros_interface_bridge_port" "hAP_ax3_ether1" {
  provider    = routeros.hAP_ax3
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax3_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax3_ether1.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether1"
  to = routeros_interface_bridge_port.hAP_ax3_ether1
}
resource "routeros_interface_bridge_port" "hAP_ax3_ether2" {
  provider    = routeros.hAP_ax3
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax3_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax3_ether2.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether2"
  to = routeros_interface_bridge_port.hAP_ax3_ether2
}
resource "routeros_interface_bridge_port" "hAP_ax3_ether3" {
  provider    = routeros.hAP_ax3
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax3_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax3_ether3.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether3"
  to = routeros_interface_bridge_port.hAP_ax3_ether3
}
resource "routeros_interface_bridge_port" "hAP_ax3_ether4" {
  provider    = routeros.hAP_ax3
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax3_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax3_ether4.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether4"
  to = routeros_interface_bridge_port.hAP_ax3_ether4
}
resource "routeros_interface_bridge_port" "hAP_ax3_ether5" {
  provider    = routeros.hAP_ax3
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax3_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax3_ether5.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether5"
  to = routeros_interface_bridge_port.hAP_ax3_ether5
}
resource "routeros_interface_bridge_port" "hAP_ax_lite_LTE6_ether1" {
  provider    = routeros.hAP_ax_lite_LTE6
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether1.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether1"
  to = routeros_interface_bridge_port.hAP_ax_lite_LTE6_ether1
}
resource "routeros_interface_bridge_port" "hAP_ax_lite_LTE6_ether2" {
  provider    = routeros.hAP_ax_lite_LTE6
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether2.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether2"
  to = routeros_interface_bridge_port.hAP_ax_lite_LTE6_ether2
}
resource "routeros_interface_bridge_port" "hAP_ax_lite_LTE6_ether3" {
  provider    = routeros.hAP_ax_lite_LTE6
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether3.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether3"
  to = routeros_interface_bridge_port.hAP_ax_lite_LTE6_ether3
}
resource "routeros_interface_bridge_port" "hAP_ax_lite_LTE6_ether4" {
  provider    = routeros.hAP_ax_lite_LTE6
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  interface   = routeros_interface_ethernet.hAP_ax_lite_LTE6_ether4.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether4"
  to = routeros_interface_bridge_port.hAP_ax_lite_LTE6_ether4
}
resource "routeros_interface_bridge_port" "wAP_ax_ether1" {
  provider    = routeros.wAP_ax
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.wAP_ax_bridge.name
  interface   = routeros_interface_ethernet.wAP_ax_ether1.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether1"
  to = routeros_interface_bridge_port.wAP_ax_ether1
}
resource "routeros_interface_bridge_port" "wAP_ax_ether2" {
  provider    = routeros.wAP_ax
  comment     = "Managed by Terraform"
  bridge      = routeros_interface_bridge.wAP_ax_bridge.name
  interface   = routeros_interface_ethernet.wAP_ax_ether2.name
  pvid        = "1"
  frame_types = "admit-all"
}
import {
  id = "interface=ether2"
  to = routeros_interface_bridge_port.wAP_ax_ether2
}




resource "routeros_wifi_datapath" "hAP_ax3_localbridge" {
  provider = routeros.hAP_ax3
  comment  = "defconf - Managed by Terraform"
  bridge   = routeros_interface_bridge.hAP_ax3_bridge.name
  name     = "capdp"
}
resource "routeros_wifi_datapath" "hAP_ax_lite_LTE6_localbridge" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "defconf - Managed by Terraform"
  bridge   = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  name     = "capdp"
}
resource "routeros_wifi_datapath" "wAP_ax_localbridge" {
  provider = routeros.wAP_ax
  comment  = "defconf - Managed by Terraform"
  bridge   = routeros_interface_bridge.wAP_ax_bridge.name
  name     = "capdp"
}

resource "routeros_wifi_cap" "hAP_ax3" {
  provider             = routeros.hAP_ax3
  discovery_interfaces = [routeros_interface_bridge.hAP_ax3_bridge.name]
  enabled              = true
  slaves_datapath      = routeros_wifi_datapath.hAP_ax3_localbridge.name
  
}
resource "routeros_wifi_cap" "hAP_ax_lite_LTE6" {
  provider             = routeros.hAP_ax_lite_LTE6
  discovery_interfaces = [routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name]
  enabled              = true
  slaves_datapath      = routeros_wifi_datapath.hAP_ax_lite_LTE6_localbridge.name
  
}
resource "routeros_wifi_cap" "wAP_ax" {
  provider             = routeros.wAP_ax
  discovery_interfaces = [routeros_interface_bridge.wAP_ax_bridge.name]
  enabled              = true
  slaves_datapath      = routeros_wifi_datapath.wAP_ax_localbridge.name
  
}


resource "routeros_wifi" "hAP_ax3_1" {
  provider = routeros.hAP_ax3
  comment  = "defconf - Managed by Terraform"
  disabled = false
  name     = "wifi1"
  configuration = {
    manager = "capsman"
  }
  lifecycle {
    ignore_changes = [datapath]
  }
}
resource "routeros_wifi" "hAP_ax3_2" {
  provider = routeros.hAP_ax3
  comment  = "defconf - Managed by Terraform"
  disabled = false
  name     = "wifi2"
  configuration = {
    manager = "capsman"
  }
  lifecycle {
    ignore_changes = [datapath]
  }
}
resource "routeros_wifi" "hAP_ax_lite_LTE6" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "defconf - Managed by Terraform"
  disabled = false
  name     = "wifi1"
  configuration = {
    manager = "capsman"
  }
  lifecycle {
    ignore_changes = [datapath]
  }
}
resource "routeros_wifi" "wAP_ax_1" {
  provider = routeros.wAP_ax
  comment  = "defconf - Managed by Terraform"
  disabled = false
  name     = "wifi1"
  configuration = {
    manager = "capsman"
  }
  lifecycle {
    ignore_changes = [datapath]
  }
}
resource "routeros_wifi" "wAP_ax_2" {
  provider = routeros.wAP_ax
  comment  = "defconf - Managed by Terraform"
  disabled = false
  name     = "wifi2"
  configuration = {
    manager = "capsman"
  }
  lifecycle {
    ignore_changes = [datapath]
  }
}

resource "routeros_ip_dhcp_client" "hAP_ax3_lan" {
  provider          = routeros.hAP_ax3
  comment           = "defconf - Managed by Terraform"
  allow_reconfigure = true
  interface         = routeros_interface_bridge.hAP_ax3_bridge.name
  use_peer_dns      = true
  use_peer_ntp      = true
}
import {
  id = "*1" # TODO: After reset and following MIKROTIK.md this will always be *1
  to = routeros_ip_dhcp_client.hAP_ax3_lan
}
resource "routeros_ip_dhcp_client" "hAP_ax_lite_LTE6_lan" {
  provider          = routeros.hAP_ax_lite_LTE6
  comment           = "defconf - Managed by Terraform"
  allow_reconfigure = true
  interface         = routeros_interface_bridge.hAP_ax_lite_LTE6_bridge.name
  use_peer_dns      = true
  use_peer_ntp      = true
}
import {
  id = "*1" # TODO: After reset and following MIKROTIK.md this will always be *1
  to = routeros_ip_dhcp_client.hAP_ax_lite_LTE6_lan
}
resource "routeros_ip_dhcp_client" "wAP_ax_lan" {
  provider          = routeros.wAP_ax
  comment           = "defconf - Managed by Terraform"
  allow_reconfigure = true
  interface         = "ether1" #routeros_interface_bridge.wAP_ax_bridge.name
  use_peer_dns      = true
  use_peer_ntp      = true
}
import {
  id = "*1" # TODO: After reset and following MIKROTIK.md this will always be *1
  to = routeros_ip_dhcp_client.wAP_ax_lan
}
