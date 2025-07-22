# ================================================================================================
# Cloud
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_cloud
# ================================================================================================
resource "routeros_ip_cloud" "rb5009" {
  provider             = routeros.rb5009
  ddns_enabled         = "yes"
  ddns_update_interval = "10m"
}
resource "routeros_ip_cloud" "hAP_ax3" {
  provider     = routeros.hAP_ax3
  ddns_enabled = "auto"
}
resource "routeros_ip_cloud" "hAP_ax_lite_LTE6" {
  provider     = routeros.hAP_ax_lite_LTE6
  ddns_enabled = "auto"
}
