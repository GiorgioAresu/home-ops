terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.85.3"
    }
  }
}

provider "routeros" {
  alias    = "rb5009"
  hosturl  = var.mikrotik_host_url_rb5009
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

provider "routeros" {
  alias    = "hAP_ax3"
  hosturl  = var.mikrotik_host_url_hap_ax3
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

provider "routeros" {
  alias    = "hAP_ax_lite_LTE6"
  hosturl  = var.mikrotik_host_url_hap_ax_lite_lte6
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

provider "routeros" {
  alias    = "hAP_ac_lite"
  hosturl  = var.mikrotik_host_url_hap_ac_lite
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

module "mikrotik_travel_router" {
  source = "./modules/mikrotik-travel-router"

  providers = {
    routeros = routeros.hAP_ac_lite
  }
}
