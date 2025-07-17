# =================================================================================================
# Bridge Interfaces
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_bridge
# =================================================================================================
resource "routeros_interface_bridge" "hAP_ax_lite_LTE6_bridge" {
  provider       = routeros.hAP_ax_lite_LTE6
  comment        = "defconf - Managed by Terraform"
  name           = "bridge"
  vlan_filtering = true
}

