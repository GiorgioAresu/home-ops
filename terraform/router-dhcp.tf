# ================================================================================================
# DHCP Client
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_client
# ================================================================================================
resource "routeros_ip_dhcp_client" "wan" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  interface    = "bridge_wan"
  use_peer_dns = false
  use_peer_ntp = false
}


# ================================================================================================
# IP Address
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_address
# ================================================================================================
resource "routeros_ip_address" "lan" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  address   = "10.17.1.1/24"
  interface = routeros_interface_bridge.bridge.name
  network   = "10.17.1.0"
}
resource "routeros_ip_address" "guest" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  address   = "10.17.30.1/24"
  interface = routeros_interface_vlan.guest.name
  network   = "10.17.30.0"
}
resource "routeros_ip_address" "security" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  address   = "10.17.40.1/24"
  interface = routeros_interface_vlan.security.name
  network   = "10.17.40.0"
}
resource "routeros_ip_address" "iot" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  address   = "10.17.50.1/24"
  interface = routeros_interface_vlan.iot.name
  network   = "10.17.50.0"
}


# ================================================================================================
# DHCP Pool Range
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_pool
# ================================================================================================
resource "routeros_ip_pool" "lan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "LAN"
  ranges   = ["10.17.1.100-10.17.1.199"]
}
resource "routeros_ip_pool" "guest" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "Guest"
  ranges   = ["10.17.30.100-10.17.30.199"]
}
resource "routeros_ip_pool" "security" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "Security"
  ranges   = ["10.17.40.100-10.17.40.199"]
}
resource "routeros_ip_pool" "iot" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "IoT"
  ranges   = ["10.17.50.100-10.17.50.199"]
}


# ================================================================================================
# DHCP Server Option
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_option
# ================================================================================================
resource "routeros_ip_dhcp_server_option" "unifi" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  code     = 43
  name     = "unifi-10.17.1.210"
  value    = "0x01040a1101d2" # https://tcpip.wtf/en/unifi-l3-adoption-with-dhcp-option-43-on-pfsense-mikrotik-and-others.htm
}


# ================================================================================================
# DHCP Network Configuration
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_network
# ================================================================================================
resource "routeros_ip_dhcp_server_network" "lan" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  address     = "10.17.1.0/24"
  gateway     = "10.17.1.1"
  dhcp_option = [routeros_ip_dhcp_server_option.unifi.name]
  dns_server  = ["10.17.1.1"]
  ntp_server  = ["10.17.1.1"]
  domain      = "aresu.eu"
}
resource "routeros_ip_dhcp_server_network" "guest" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  address     = "10.17.30.0/24"
  gateway     = "10.17.30.1"
  dns_server  = ["10.17.30.1"]
  ntp_server  = ["10.17.30.1"]
  # domain      = "aresu.eu"
}
resource "routeros_ip_dhcp_server_network" "security" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  address     = "10.17.40.0/24"
  gateway     = "10.17.40.1"
  dns_server  = ["10.17.40.1"]
  ntp_server  = ["10.17.40.1"]
  domain      = "sec.aresu.eu"
}
resource "routeros_ip_dhcp_server_network" "iot" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  address     = "10.17.50.0/24"
  gateway     = "10.17.50.1"
  dns_server  = ["10.17.50.1"]
  ntp_server  = ["10.17.50.1"]
  domain      = "iot.aresu.eu"
}


# ================================================================================================
# DHCP Server Configuration
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server
# ================================================================================================
resource "routeros_ip_dhcp_server" "lan" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  name         = "LAN"
  address_pool = routeros_ip_pool.lan.name
  interface    = routeros_interface_bridge.bridge.name
}
resource "routeros_ip_dhcp_server" "guest" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  name         = "Guest"
  address_pool = routeros_ip_pool.guest.name
  interface    = routeros_interface_vlan.guest.name
}
resource "routeros_ip_dhcp_server" "security" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  name         = "Security"
  address_pool = routeros_ip_pool.security.name
  interface    = routeros_interface_vlan.security.name
}
resource "routeros_ip_dhcp_server" "iot" {
  provider     = routeros.rb5009
  comment      = "Managed by Terraform"
  name         = "IoT"
  address_pool = routeros_ip_pool.iot.name
  interface    = routeros_interface_vlan.iot.name
}


# ================================================================================================
# Static DHCP Leases
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dhcp_server_lease
# ================================================================================================
### LAN
resource "routeros_ip_dhcp_server_lease" "truenas" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - TrueNAS Scale"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.2"
  mac_address = "2A:B4:73:FB:C0:23"
}
resource "routeros_ip_dhcp_server_lease" "supermicro" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Supermicro"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.3"
  mac_address = "0C:C4:7A:6B:59:EA"
}
resource "routeros_ip_dhcp_server_lease" "homeassistant" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Home Assistant"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.4"
  mac_address = "00:1E:06:42:74:6E"
}
resource "routeros_ip_dhcp_server_lease" "nextcloud" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Nextcloud"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.5"
  mac_address = "BE:EE:E1:21:BC:71"
}
resource "routeros_ip_dhcp_server_lease" "pi_0_2w" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Pi Zero 2W"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.6"
  mac_address = "E4:5F:01:90:D9:A7"
}
resource "routeros_ip_dhcp_server_lease" "prusa" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Prusa MK3.5S"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.7"
  mac_address = "EC:64:C9:F3:C0:F8"
}
resource "routeros_ip_dhcp_server_lease" "rpi_4_1" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - kube-rpi-01"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.30"
  mac_address = "E4:5F:01:48:D7:4F"
}
resource "routeros_ip_dhcp_server_lease" "rpi_4_2" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - kube-rpi-02"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.32"
  mac_address = "E4:5F:01:96:B3:70"
}
resource "routeros_ip_dhcp_server_lease" "bmax_b4_plus" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - BMAX B4 Plus"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.34"
  mac_address = "00:E0:4C:2E:36:08"
}
resource "routeros_ip_dhcp_server_lease" "unraid" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Unraid"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.35"
  mac_address = "AA:15:AA:E8:C4:CB"
}
resource "routeros_ip_dhcp_server_lease" "kube_proxmox_01" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.36"
  mac_address = "BC:24:11:41:5F:39"
}
resource "routeros_ip_dhcp_server_lease" "kube_proxmox_02" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.37"
  mac_address = "BC:24:11:EF:8F:39"
}
resource "routeros_ip_dhcp_server_lease" "kube_nuc_01" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - kube-nuc-01"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.38"
  mac_address = "68:5B:35:A1:01:CA"
}
resource "routeros_ip_dhcp_server_lease" "zigbee" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - SMLIGHT SLZB-06M"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.40"
  mac_address = "0C:DC:7E:37:4F:7F"
}
resource "routeros_ip_dhcp_server_lease" "ipmi_asrockrack" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - IPMI ASRockRack"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.50"
  mac_address = "BC:5F:F4:FE:FC:24"
}
resource "routeros_ip_dhcp_server_lease" "ipmi_supermicro" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - IPMI SuperMicro"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.51"
  mac_address = "0C:C4:7A:6D:FE:8F"
}
resource "routeros_ip_dhcp_server_lease" "printer_eth" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - HP M26nw Printer (ETH)"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.64"
  mac_address = "F4:30:B9:70:EE:1B"
}
resource "routeros_ip_dhcp_server_lease" "printer_wifi" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - HP M26nw Printer (WiFi)"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.65"
  mac_address = "54:13:79:0F:09:86"
}
resource "routeros_ip_dhcp_server_lease" "unifi_usw_mini" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - USW_MINI"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.66"
  mac_address = "74:83:C2:0F:33:4C"
}
resource "routeros_ip_dhcp_server_lease" "unifi_uap_ac_lite" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - UAP_AC_Lite"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.67"
  mac_address = "FC:EC:DA:89:1E:52"
}
resource "routeros_ip_dhcp_server_lease" "mikrotik_hap_ax3" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Mikrotik hAP ax3"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.68"
  mac_address = "D4:01:C3:4E:1E:E0"
}
resource "routeros_ip_dhcp_server_lease" "mikrotik_hap_ax_lite_lte6" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Mikrotik hAP ax lite LTE6"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.69"
  mac_address = "78:9A:18:77:17:18"
}
resource "routeros_ip_dhcp_server_lease" "framework" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Framework Laptop"
  server      = routeros_ip_dhcp_server.lan.name
  address     = "10.17.1.99"
  mac_address = "9E:3C:2C:78:26:29"
}
resource "routeros_ip_dhcp_server_lease" "camera_bullet" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Bullet camera"
  server      = routeros_ip_dhcp_server.security.name
  address     = "10.17.50.122"
  mac_address = "00:00:1B:0C:C7:8E"
}
resource "routeros_ip_dhcp_server_lease" "camera_dome" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Dome camera"
  server      = routeros_ip_dhcp_server.security.name
  address     = "10.17.50.128"
  mac_address = "00:00:1B:04:FB:E7"
}

### IoT
resource "routeros_ip_dhcp_server_lease" "m5stack_atom_echo" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - M5Stack Atom Echo"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.30"
  mac_address = "14:2B:2F:A0:36:4C"
}
resource "routeros_ip_dhcp_server_lease" "bagno_principale" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Bagno principale"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.31"
  mac_address = "8C:BF:EA:CC:79:F4"
}
resource "routeros_ip_dhcp_server_lease" "dehumidifier" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Dehumidifier"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.32"
  mac_address = "CC:50:E3:B5:D6:F4"
}
resource "routeros_ip_dhcp_server_lease" "teckin" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Rack (Teckin)"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.33"
  mac_address = "84:0D:8E:5F:66:28"
}
resource "routeros_ip_dhcp_server_lease" "tplink_hs110" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - TP-Link HS110 (Kasa)"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.34"
  mac_address = "D8:0D:17:81:0F:4A"
}
resource "routeros_ip_dhcp_server_lease" "sonoff_rf_bridge" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Sonoff RF-Bridge"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.35"
  mac_address = "60:01:94:B2:DC:86"
}
resource "routeros_ip_dhcp_server_lease" "stufetta" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Stufetta"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.36"
  mac_address = "EC:FA:BC:9B:C6:31"
}
resource "routeros_ip_dhcp_server_lease" "ble_tracker" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - BLE Tracker"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.37"
  mac_address = "CC:50:E3:B5:BE:08"
}
resource "routeros_ip_dhcp_server_lease" "persiana" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Persiana"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.38"
  mac_address = "DC:4F:22:5F:5F:43"
}
resource "routeros_ip_dhcp_server_lease" "inverter" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Huawei SUN2000"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.39"
  mac_address = "C4:D4:38:DB:94:08"
}
resource "routeros_ip_dhcp_server_lease" "asciugatrice" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Miele"
  server      = routeros_ip_dhcp_server.iot.name
  address     = "10.17.50.40"
  mac_address = "00:1D:63:63:B5:C2"
}
# resource "routeros_ip_dhcp_server_lease" "this" { *16
#   provider    = routeros.rb5009
#   comment     = "Managed by Terraform"
#   server      = routeros_ip_dhcp_server.iot.name
#   address     = "10.17.50.109"
#   mac_address = "EC:DA:3B:9B:26:EC"
# }
