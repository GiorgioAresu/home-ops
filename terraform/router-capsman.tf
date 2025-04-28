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
  width             = "20mhz"
  skip_dfs_channels = "all"
  reselect_interval = "45m..1h"
}


# =================================================================================================
# WiFi Security
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/wifi_security
# =================================================================================================
resource "routeros_wifi_security" "main_wifi_security" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "GeS"
  authentication_types = ["wpa2-psk"] // Add wpa3 at some point
  passphrase           = var.main_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [ passphrase ]
  }
}
resource "routeros_wifi_security" "guest_wifi_security" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "Guest"
  authentication_types = ["wpa2-psk"] // Add wpa3 at some point
  passphrase           = var.guest_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [ passphrase ]
  }
}
resource "routeros_wifi_security" "iot_wifi_security" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "IoT"
  authentication_types = ["wpa2-psk"] // Add wpa3 at some point
  passphrase           = var.iot_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [ passphrase ]
  }
}
resource "routeros_wifi_security" "iottemp_wifi_security" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform"
  name                 = "IoT-temp"
  authentication_types = ["wpa2-psk"]
  passphrase           = var.iottemp_wifi_password
  ft                   = true
  ft_over_ds           = true

  lifecycle {
    ignore_changes = [ passphrase ]
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
  bridge   = "bridge"
}
resource "routeros_wifi_datapath" "guest" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "Guest"
  bridge   = "bridge"
  vlan_id  = 30
}
resource "routeros_wifi_datapath" "security" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "Security"
  bridge   = "bridge"
  vlan_id  = 40
  client_isolation = true
}
resource "routeros_wifi_datapath" "iot" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "IoT"
  bridge   = "bridge"
  vlan_id  = 50
  client_isolation = true
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
    config = routeros_wifi_security.main_wifi_security.name
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
    config = routeros_wifi_security.main_wifi_security.name
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
    config = routeros_wifi_datapath.lan.name
  }
  security = {
    config = routeros_wifi_security.guest_wifi_security.name
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
    config = routeros_wifi_datapath.lan.name
  }
  security = {
    config = routeros_wifi_security.guest_wifi_security.name
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
    config = routeros_wifi_security.iot_wifi_security.name
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
    config = routeros_wifi_security.iot_wifi_security.name
  }
}
resource "routeros_wifi_configuration" "iot-temp" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  country  = "Italy"
  name     = "IoT-temp"
  mode     = "ap"
  ssid     = "GeS-IoT"

  channel = {
    config = routeros_wifi_channel.slow.name
  }
  datapath = {
    config = routeros_wifi_datapath.lan.name
  }
  security = {
    config = routeros_wifi_security.iottemp_wifi_security.name
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
  disabled             = true
  supported_bands      = ["2ghz-n"]
  master_configuration = routeros_wifi_configuration.main_2ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_2ghz.name,
    routeros_wifi_configuration.iot-downstairs.name,
    routeros_wifi_configuration.iot-temp.name,
  ]
}
resource "routeros_wifi_provisioning" "hap_ax3_2ghz" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - hAP ax3 2GHz (guests only downstairs, modem will need both)"
  action               = "create-dynamic-enabled"
  disabled             = false
  radio_mac            = "D4:01:C3:4E:1E:E6"
  master_configuration = routeros_wifi_configuration.main_2ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_2ghz.name,
    routeros_wifi_configuration.iot-downstairs.name,
  ]
}
resource "routeros_wifi_provisioning" "hap_axlite" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - hAP ax lite LTE"
  action               = "create-dynamic-enabled"
  disabled             = false
  radio_mac            = "78:9A:18:77:17:1C"
  master_configuration = routeros_wifi_configuration.main_2ghz.name
  slave_configurations = [
    routeros_wifi_configuration.guest_2ghz.name,
    routeros_wifi_configuration.iot-upstairs.name,
    routeros_wifi_configuration.iot-temp.name,
  ]
}

