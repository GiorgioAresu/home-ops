resource "routeros_interface_wireless" "station" {
  comment                 = "Managed by Terraform"
  adaptive_noise_immunity = "ap-and-client-mode"
  channel_width           = "20mhz"
  compression             = true
  country                 = "italy"
  installation            = "indoor"
  mode                    = "station-pseudobridge-clone"
  name                    = "wlan1"
  # security_profile              = "wlan1-GiorgioSpindox-repeater"
  # ssid                          = "GiorgioSpindox"
  station_bridge_clone_mac = "9E:3C:2C:78:26:29"
  station_roaming          = "enabled"
  # vlan_id                       = 1
  # vlan_mode                     = "no-tag"
  wps_mode = "disabled"
}

resource "routeros_interface_wireless_security_profiles" "known_wifis" {
  for_each = {
    for wifi in var.known_wifis :
    wifi.ssid => wifi
    if length(trimspace(wifi.password)) > 0
  }

  comment              = "Managed by Terraform - [STATION] ${each.value.comment}"
  name                 = "station_${each.key}"
  mode                 = "dynamic-keys"
  authentication_types = ["wpa2-psk"]
  wpa2_pre_shared_key  = each.value.password
}

resource "routeros_interface_wireless_connect_list" "known_wifis" {
  for_each = {
    for wifi in var.known_wifis :
    wifi.ssid => wifi
  }

  comment   = "Managed by Terraform - ${each.value.comment}"
  interface = routeros_interface_wireless.station.name
  ssid      = each.value.ssid
  security_profile = (
    contains(keys(routeros_interface_wireless_security_profiles.known_wifis), each.key)
    ? routeros_interface_wireless_security_profiles.known_wifis[each.key].name
    : "none"
  )
  disabled          = false
  connect           = coalesce(each.value.enabled, true)
  wireless_protocol = "802.11"
  mac_address       = each.value.mac_address
}

resource "routeros_interface_wireless_security_profiles" "bridge" {
  comment              = "Managed by Terraform"
  authentication_types = ["wpa2-psk"]
  # management_protection     = "allowed"
  # management_protection_key = null # sensitive
  mode                = "dynamic-keys"
  name                = "GeS-Bridge"
  wpa2_pre_shared_key = var.bridge_wifi_password
}

resource "routeros_interface_wireless_security_profiles" "travel" {
  comment              = "Managed by Terraform"
  authentication_types = ["wpa2-psk"]
  # management_protection     = "allowed"
  # management_protection_key = null # sensitive
  mode                = "dynamic-keys"
  name                = "GeS-Travel"
  wpa2_pre_shared_key = var.travel_wifi_password
}
# resource "routeros_interface_wireless_security_profiles" "home" {
#   comment              = "Managed by Terraform"
#   authentication_types = ["wpa2-psk"]
#   # management_protection     = "allowed"
#   # management_protection_key = null # sensitive
#   mode                = "dynamic-keys"
#   name                = "GeS"
#   wpa2_pre_shared_key = var.main_wifi_password
# }

resource "routeros_interface_wireless" "travel" {
  comment          = "Managed by Terraform"
  master_interface = routeros_interface_wireless.station.name
  mode             = "ap-bridge"
  name             = "wlan-travel"
  security_profile = routeros_interface_wireless_security_profiles.travel.name
  ssid             = "GeS-Travel"
  vlan_id          = 1
  vlan_mode        = "no-tag"
  wps_mode         = "disabled"
  disabled         = "false"
}
resource "routeros_interface_wireless" "bridge" {
  comment          = "Managed by Terraform"
  master_interface = routeros_interface_wireless.station.name
  mode             = "ap-bridge"
  name             = "wlan-bridge"
  security_profile = routeros_interface_wireless_security_profiles.bridge.name
  ssid             = "GeS-Bridge"
  vlan_id          = 1
  vlan_mode        = "no-tag"
  wps_mode         = "disabled"
  disabled         = "false"
}
# resource "routeros_interface_wireless" "home" {
#   comment          = "Managed by Terraform"
#   master_interface = routeros_interface_wireless.station.name
#   mode             = "ap-bridge"
#   name             = "wlan-home"
#   security_profile = routeros_interface_wireless_security_profiles.home.name
#   ssid             = "GeS-Tunnel"
#   vlan_id          = 1
#   vlan_mode        = "no-tag"
#   wps_mode         = "disabled"
#   disabled         = "false"
# }
