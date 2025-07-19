# =================================================================================================
# DNS
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dns
# =================================================================================================
resource "routeros_ip_dns" "dns-server" {
  provider              = routeros.rb5009
  allow_remote_requests = true
  cache_size            = 20480
  servers = [
    "1.1.1.1",
    "1.0.0.1",
  ]
}

# =================================================================================================
# DNS AdList
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dns_adlist
# =================================================================================================
resource "routeros_ip_dns_adlist" "stevenblack" {
  provider   = routeros.rb5009
  url        = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
  ssl_verify = false
}


# =================================================================================================
# DNS Record
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dns_record
# =================================================================================================
resource "routeros_ip_dns_record" "router" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "router.lan"
  address  = "10.17.1.1"
}
resource "routeros_ip_dns_record" "truenas" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "truenas.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.truenas.address
}
resource "routeros_ip_dns_record" "mqtt" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "mqtt.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.homeassistant.address
}
resource "routeros_ip_dns_record" "supermicro" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "pve-supermicro.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.supermicro.address
}
resource "routeros_ip_dns_record" "proxmox_supermicro" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "proxmox.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.supermicro.address
}
resource "routeros_ip_dns_record" "proxmox_minisforum_uh125" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "proxmox.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.minisforum_uh125.address
}
resource "routeros_ip_dns_record" "prusa" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "prusa.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.prusa.address
}
resource "routeros_ip_dns_record" "unraid" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "unraid.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.unraid.address
}
resource "routeros_ip_dns_record" "kube-bmax-01" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "kube-bmax-01.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.bmax_b4_plus.address
}
resource "routeros_ip_dns_record" "kube_proxmox_01" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "kube-proxmox-01.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.kube_proxmox_01.address
}
resource "routeros_ip_dns_record" "kube_proxmox_02" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "kube-proxmox-02.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.kube_proxmox_02.address
}
resource "routeros_ip_dns_record" "kube_nuc_01" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "kube-nuc-01.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.kube_nuc_01.address
}
resource "routeros_ip_dns_record" "zigbee" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "zigbee.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.zigbee.address
}

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
resource "routeros_ip_dns_record" "ipmi_asrockrack" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "ipmi-asrockrack.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.ipmi_asrockrack.address
}
resource "routeros_ip_dns_record" "ipmi_supermicro" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  type     = "A"
  name     = "ipmi-supermicro.aresu.eu"
  address  = routeros_ip_dhcp_server_lease.ipmi_supermicro.address
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

resource "routeros_ip_dns_record" "odroidhc4" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - Odroid HC4 offsite backup target"
  type     = "A"
  name     = "odroidhc4.aresu.eu"
  address  = "10.17.100.50"
}
