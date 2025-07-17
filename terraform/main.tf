terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.85.3"
    }
    unifi = {
      source  = "paultyng/unifi"
      version = "0.41.0"
    }
  }
}

module "mikrotik_travel_router" {
  source = "./modules/mikrotik-travel-router"

  mikrotik_host_url_hap_ac_lite = var.mikrotik_host_url_hap_ac_lite
  mikrotik_username             = var.mikrotik_username
  mikrotik_password             = var.mikrotik_password
  mikrotik_insecure             = var.mikrotik_insecure
}

module "network" {
  source = "./modules/network"

  mikrotik_host_url_rb5009           = var.mikrotik_host_url_rb5009
  mikrotik_host_url_hap_ax3          = var.mikrotik_host_url_hap_ax3
  mikrotik_host_url_hap_ax_lite_lte6 = var.mikrotik_host_url_hap_ax_lite_lte6
  mikrotik_username                  = var.mikrotik_username
  mikrotik_password                  = var.mikrotik_password
  mikrotik_insecure                  = var.mikrotik_insecure
  mikrotik_user_homepage_password    = var.mikrotik_user_homepage_password
  mikrotik_user_mktxp_password       = var.mikrotik_user_mktxp_password
  mikrotik_user_externaldns_password = var.mikrotik_user_externaldns_password

  unifi_api_url  = var.unifi_api_url
  unifi_username = var.unifi_username
  unifi_password = var.unifi_password

  main_wifi_password  = var.main_wifi_password
  guest_wifi_password = var.guest_wifi_password
  iot_wifi_password   = var.iot_wifi_password
}
