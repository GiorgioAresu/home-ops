resource "routeros_interface_lte_apn" "vodafone" {
  provider      = routeros.hAP_ax_lite_LTE6
  comment       = "Managed by Terraform"
  apn           = "mobile.vodafone.it"
  name          = "vodafone"
  # passthrough_interface = ""
}

resource "routeros_interface_lte" "lte" {
  provider      = routeros.hAP_ax_lite_LTE6
  comment       = "Managed by Terraform"
  allow_roaming = false
  apn_profiles  = routeros_interface_lte_apn.vodafone.name
  disabled      = false
  name          = "lte1"
  sms_read      = "true"
}
