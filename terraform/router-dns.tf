resource "routeros_ip_dns_record" "jetkvm" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "jetkvm.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.jetkvm.address
}
resource "routeros_ip_dns_record" "minisforum_uh125" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "pve-minisforum.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.minisforum_uh125.address
}

resource "routeros_ip_dns_record" "m5stack_atom_echo" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "m5stack-atom-echo.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.m5stack_atom_echo.address
}
resource "routeros_ip_dns_record" "bagno_principale" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "bagno-principale.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.bagno_principale.address
}
resource "routeros_ip_dns_record" "dehumidifier" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "dehumidifier.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.dehumidifier.address
}
resource "routeros_ip_dns_record" "hass" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "hass.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.hass.address
}
resource "routeros_ip_dns_record" "teckin" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "teckin.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.teckin.address
}
resource "routeros_ip_dns_record" "tplink_hs110" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "hs110.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.tplink_hs110.address
}
resource "routeros_ip_dns_record" "sonoff_rf_bridge" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "rf-bridge.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.sonoff_rf_bridge.address
}
resource "routeros_ip_dns_record" "stufetta" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "stufetta.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.stufetta.address
}
resource "routeros_ip_dns_record" "ble_tracker" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "ble-tracker.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.ble_tracker.address
}
resource "routeros_ip_dns_record" "persiana" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "persiana.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.persiana.address
}
resource "routeros_ip_dns_record" "inverter" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "inverter.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.inverter.address
}
resource "routeros_ip_dns_record" "asciugatrice" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "asciugatrice.iot.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.asciugatrice.address
}
