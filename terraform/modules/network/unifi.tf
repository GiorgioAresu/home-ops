resource "unifi_setting_mgmt" "home" {
  auto_upgrade = "false"
}

data "unifi_user_group" "default" {
}

data "unifi_ap_group" "default" {
}

data "unifi_network" "main" {
  name = "Default"
}

resource "unifi_port_profile" "guest" {
  name                  = "Guest"
  native_networkconf_id = unifi_network.guest.id
  forward               = "native"
  poe_mode              = "off"
}

resource "unifi_port_profile" "iot" {
  name                  = "IoT"
  native_networkconf_id = unifi_network.iot.id
  forward               = "native"
  poe_mode              = "off"
}

resource "unifi_device" "usw_flex_mini" {
  mac  = "74:83:c2:0f:33:4c"
  name = "USW Flex Mini (Desk)"

  port_override {
    number          = 5
    name            = "IoT"
    port_profile_id = unifi_port_profile.iot.id
  }
}

resource "unifi_device" "uap_ac_lite" {
  mac  = "FC:EC:DA:89:1E:52"
  name = "UAP AC Lite"
}
