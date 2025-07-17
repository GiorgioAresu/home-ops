# =================================================================================================
# CAPsMAN Settings
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_capsman
# =================================================================================================
resource "routeros_wifi_capsman" "settings" {
  provider       = routeros.rb5009
  ca_certificate = "auto"
  enabled        = true
}


# =================================================================================================
# WiFi Channels
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_channel
# =================================================================================================
resource "routeros_wifi_channel" "slow" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform"
  name              = "2ghz"
  width             = "20mhz"
  skip_dfs_channels = "all"
  frequency         = [2412, 2437, 2462]
  reselect_interval = "45m..1h"
}
resource "routeros_wifi_channel" "fast" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform"
  name              = "5ghz"
  width             = "20/40mhz"
  skip_dfs_channels = "all"
  reselect_interval = "45m..1h"
}


# =================================================================================================
# WiFi Security
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_security
# =================================================================================================
resource "routeros_wifi_security" "main_wifi" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "GeS"
  authentication_types = ["wpa2-psk"] # TODO: enable wpa3 at some point
  passphrase           = var.main_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [passphrase]
  }
}
resource "routeros_wifi_security" "guest_wifi" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "Guest"
  authentication_types = ["wpa2-psk"] # TODO: enable wpa3 at some point
  passphrase           = var.guest_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [passphrase]
  }
}
resource "routeros_wifi_security" "iot_wifi" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "IoT"
  authentication_types = ["wpa2-psk"] # TODO: enable wpa3 at some point
  passphrase           = var.iot_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [passphrase]
  }
}


# =================================================================================================
# WiFi Datapath
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_datapath
# =================================================================================================
resource "routeros_wifi_datapath" "lan" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "LAN"
  bridge   = routeros_interface_bridge.bridge.name
}
resource "routeros_wifi_datapath" "guest" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "Guest"
  bridge   = routeros_interface_bridge.bridge.name
  vlan_id  = local.vlan_id_guest
}
resource "routeros_wifi_datapath" "security" {
  provider         = routeros.rb5009
  comment          = "Managed by Terraform"
  name             = "Security"
  bridge           = routeros_interface_bridge.bridge.name
  vlan_id          = local.vlan_id_security
  client_isolation = true
}
resource "routeros_wifi_datapath" "iot" {
  provider         = routeros.rb5009
  comment          = "Managed by Terraform"
  name             = "IoT"
  bridge           = routeros_interface_bridge.bridge.name
  vlan_id          = local.vlan_id_iot
  client_isolation = false
}

# =================================================================================================
# WiFi Configurations
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_configuration
# =================================================================================================
resource "routeros_wifi_configuration" "main_5ghz" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "GeS-5GHz"
  mode     = "ap"
  ssid     = "GeS"

  channel = {
    config = routeros_wifi_channel.fast.name
  }
  datapath = {
    config = routeros_wifi_datapath.lan.name
  }
  security = {
    config = routeros_wifi_security.main_wifi.name
  }
}
resource "routeros_wifi_configuration" "main_2ghz" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "GeS-2GHz"
  mode     = "ap"
  ssid     = "GeS"

  channel = {
    config = routeros_wifi_channel.slow.name
  }
  datapath = {
    config = routeros_wifi_datapath.lan.name
  }
  security = {
    config = routeros_wifi_security.main_wifi.name
  }
}
resource "routeros_wifi_configuration" "guest_5ghz" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "GeS-Guest-5GHz"
  mode     = "ap"
  ssid     = "GeS-Guest"

  channel = {
    config = routeros_wifi_channel.fast.name
  }
  datapath = {
    config = routeros_wifi_datapath.guest.name
  }
  security = {
    config = routeros_wifi_security.guest_wifi.name
  }
}
resource "routeros_wifi_configuration" "guest_2ghz" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "GeS-Guest-2GHz"
  mode     = "ap"
  ssid     = "GeS-Guest"

  channel = {
    config = routeros_wifi_channel.slow.name
  }
  datapath = {
    config = routeros_wifi_datapath.guest.name
  }
  security = {
    config = routeros_wifi_security.guest_wifi.name
  }
}
resource "routeros_wifi_configuration" "iot-downstairs" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "IoT-downstairs"
  mode     = "ap"
  ssid     = "GeS-IoT-d"

  channel = {
    config = routeros_wifi_channel.slow.name
  }
  datapath = {
    config = routeros_wifi_datapath.iot.name
  }
  security = {
    config = routeros_wifi_security.iot_wifi.name
  }
}
resource "routeros_wifi_configuration" "iot-upstairs" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "IoT-upstairs"
  mode     = "ap"
  ssid     = "GeS-IoT-u"

  channel = {
    config = routeros_wifi_channel.slow.name
  }
  datapath = {
    config = routeros_wifi_datapath.iot.name
  }
  security = {
    config = routeros_wifi_security.iot_wifi.name
  }
}
resource "routeros_wifi_configuration" "iot" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "IoT"
  mode     = "ap"
  ssid     = "GeS-IoT"

  channel = {
    config = routeros_wifi_channel.slow.name
  }
  datapath = {
    config = routeros_wifi_datapath.iot.name
  }
  security = {
    config = routeros_wifi_security.iot_wifi.name
  }
}


# =================================================================================================
# WiFi Provisioning
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_provisioning
# =================================================================================================
# TODO: change to 1 per channel
resource "routeros_wifi_provisioning" "all_5ghz" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - All 5GHz"
  action               = "create-dynamic-enabled"
  supported_bands      = ["5ghz-n"]
  master_configuration = routeros_wifi_configuration.main_5ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_5ghz.name
  ]
}
resource "routeros_wifi_provisioning" "all_2ghz" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - All 2GHz"
  action               = "create-dynamic-enabled"
  disabled             = false
  supported_bands      = ["2ghz-n"]
  master_configuration = routeros_wifi_configuration.main_2ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_2ghz.name,
    routeros_wifi_configuration.iot.name,
  ]
}
resource "routeros_wifi_provisioning" "hap_ax3_2ghz" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - hAP ax3 2GHz (guests only downstairs, modem will need both)"
  action               = "create-dynamic-enabled"
  disabled             = true
  radio_mac            = "D4:01:C3:4E:1E:E6"
  master_configuration = routeros_wifi_configuration.main_2ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_2ghz.name,
    routeros_wifi_configuration.iot-downstairs.name,
    routeros_wifi_configuration.iot.name,
  ]
}
resource "routeros_wifi_provisioning" "hap_axlite" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - hAP ax lite LTE"
  action               = "create-dynamic-enabled"
  disabled             = true
  radio_mac            = "78:9A:18:77:17:1C"
  master_configuration = routeros_wifi_configuration.main_2ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_2ghz.name,
    routeros_wifi_configuration.iot-upstairs.name,
    routeros_wifi_configuration.iot.name,
  ]
}

resource "unifi_wlan" "main" {
  name          = "GeS"
  passphrase    = var.main_wifi_password
  security      = "wpapsk"
  ap_group_ids  = [data.unifi_ap_group.default.id]
  user_group_id = data.unifi_user_group.default.id
  network_id    = data.unifi_network.main.id

  # TODO: enable wpa3 at some point
  wpa3_support    = false
  wpa3_transition = false
  pmf_mode        = "optional"

  fast_roaming_enabled = "true"
  wlan_band            = "both"
}

resource "unifi_wlan" "guest" {
  name          = "GeS-Guest-test"
  passphrase    = var.guest_wifi_password
  security      = "wpapsk"
  ap_group_ids  = [data.unifi_ap_group.default.id]
  user_group_id = data.unifi_user_group.default.id
  network_id    = unifi_network.guest.id

  # TODO: enable wpa3 at some point
  wpa3_support    = false
  wpa3_transition = false
  pmf_mode        = "optional"

  fast_roaming_enabled = "true"
  # l2_isolation         = "true"
  wlan_band = "both"
}

# resource "unifi_wlan" "iot" {
#   name          = "GeS-IoT"
#   passphrase    = var.iot_wifi_password
#   security      = "wpapsk"
#   ap_group_ids  = [data.unifi_ap_group.default.id]
#   user_group_id = data.unifi_user_group.default.id
#   network_id    = unifi_network.iot.id

#   # TODO: enable wpa3 at some point
#   wpa3_support    = false
#   wpa3_transition = false
#   pmf_mode        = "optional"

#   fast_roaming_enabled = "true"
#   # l2_isolation         = "true"
#   wlan_band = "2g"
# }
