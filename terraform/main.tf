module "mikrotik_travel_router" {
  source = "./modules/mikrotik-travel-router"

  mikrotik_host_url_hap_ac_lite = var.mikrotik_host_url_hap_ac_lite
  mikrotik_username = var.mikrotik_username
  mikrotik_password = var.mikrotik_password
  mikrotik_insecure = var.mikrotik_insecure
}

module "network" {
  source = "./modules/network"

  mikrotik_host_url_rb5009 = var.mikrotik_host_url_rb5009
  mikrotik_host_url_hap_ax3 = var.mikrotik_host_url_hap_ax3
  mikrotik_host_url_hap_ax_lite_lte6 = var.mikrotik_host_url_hap_ax_lite_lte6
  mikrotik_username = var.mikrotik_username
  mikrotik_password = var.mikrotik_password
  mikrotik_insecure = var.mikrotik_insecure
}
