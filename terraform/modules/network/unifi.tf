resource "unifi_setting_mgmt" "home" {
  auto_upgrade = "false"
}

data "unifi_user_group" "default" {
}

data "unifi_ap_group" "default" {
}

resource "unifi_device" "usw_flex_mini" {
  mac = "74:83:c2:0f:33:4c"

  name = "USW Flex Mini (Desk)"

  # port_override {
  #   number          = 1
  #   name            = "port w/ poe"
  #   port_profile_id = unifi_port_profile.poe.id
  # }

  # port_override {
  #   number          = 2
  #   name            = "disabled"
  #   port_profile_id = data.unifi_port_profile.disabled.id
  # }

  # # port aggregation for ports 11 and 12
  # port_override {
  #   number              = 11
  #   op_mode             = "aggregate"
  #   aggregate_num_ports = 2
  # }
}

resource "unifi_device" "uap_ac_lite" {
  mac = "FC:EC:DA:89:1E:52"

  name = "UAP AC Lite"
}
