terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
  }
}

provider "routeros" {
  alias    = "hAP_ac2"
  hosturl  = var.mikrotik_host_url_hap_ac2
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

provider "routeros" {
  alias    = "hAP_lite_TC"
  hosturl  = var.mikrotik_host_url_hap_lite_tc
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

provider "routeros" {
  alias    = "wAP_R"
  hosturl  = var.mikrotik_host_url_wap_r
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

provider "routeros" {
  alias    = "rB915Ui_2HnD"
  hosturl  = var.mikrotik_host_url_rb915ui_2hnd
  username = var.mikrotik_username
  password = var.mikrotik_password
  insecure = var.mikrotik_insecure
}

locals {
  vlan_id_wan_backup = 2
  addr_list_bad_ipv6 = "bad_ipv6"
}
