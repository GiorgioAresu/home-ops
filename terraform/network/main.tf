terraform {
  required_providers {
    routeros = {
      source  = "terraform-routeros/routeros"
      version = "1.99.1"
    }
    unifi = {
      source  = "paultyng/unifi"
      version = "0.41.0"
    }
  }

  backend "s3" {
    bucket                 = "terraform"
    insecure               = true # TODO: Remove after fixing traefik certs
    key                    = "home-ops/terraform/network.tfstate"
    region                 = "garage"

    skip_region_validation = true
    use_lockfile           = true
    use_path_style         = true
    # Required for non-AWS S3-compatible backends to avoid hitting AWS endpoints
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true

    endpoints = {
      s3 = "https://s3.aresu.eu"
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

provider "unifi" {
  username       = var.unifi_username
  password       = var.unifi_password
  api_url        = var.unifi_api_url
  allow_insecure = var.unifi_insecure
}

locals {
  vlan_id_wan_backup       = 2
  vlan_id_guest            = 30
  vlan_id_security         = 40
  vlan_id_iot              = 50
  vlan_id_vpn_exit         = 90
  addr_list_bad_ipv6       = "bad_ipv6"
  bgp_as_local             = 64513
  bgp_as_remote_kubernetes = 64514
}
