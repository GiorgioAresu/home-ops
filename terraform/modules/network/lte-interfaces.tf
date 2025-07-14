# =================================================================================================
# Bridge Interfaces
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "lte_bridge" {
  provider       = routeros.hAP_ax_lite_LTE6
  comment        = "defconf - Managed by Terraform"
  name           = "bridge"
  vlan_filtering = false
}


resource "routeros_interface_lte_apn" "vodafone" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  apn      = "mobile.vodafone.it"
  name     = "vodafone"
  # passthrough_interface = routeros_interface_vlan.lte_lte.name
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
