terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.86.2"
    }
  }
}

provider "routeros" {
  hosturl      = var.mikrotik_host_url
  username     = var.mikrotik_username
  password     = var.mikrotik_password
  insecure     = var.mikrotik_insecure
  rest_timeout = 120 # Increased due to sloooow CPU
}

locals {
  vlan_id_home = 10
}
