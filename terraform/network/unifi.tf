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

resource "unifi_port_profile" "desk" {
  name                  = "Desk"
  native_networkconf_id = unifi_network.guest.id
  forward               = "customize"
  poe_mode              = "off"
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
    number          = 1
    name            = "Upstream"
  }

  port_override {
    number          = 2
    name            = "Desk"
    port_profile_id = unifi_port_profile.desk.id

  }

  port_override {
    number          = 3
  }

  port_override {
    number          = 4
  }

  port_override {
    number          = 5
    name            = "IoT"
    port_profile_id = unifi_port_profile.iot.id
  }

  lifecycle {
    ignore_changes = [ port_override ] # The switch doesn't properly support VLANs, so I'm just keeping the config but needs changes in the UI
  }
}

resource "unifi_device" "uap_ac_lite" {
  mac  = "FC:EC:DA:89:1E:52"
  name = "UAP AC Lite"
}
