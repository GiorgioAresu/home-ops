# =================================================================================================
# Wireguard
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_wireguard
# =================================================================================================
resource "routeros_interface_wireguard" "travel" {
  comment     = "Managed by Terraform - Home"
  disabled    = false
  listen_port = 13231
  mtu         = "1420"
  name        = "wireguard"
  private_key = var.wireguard_private_key
}


# =================================================================================================
# Wireguard Peer
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_wireguard_peer
# =================================================================================================
resource "routeros_interface_wireguard_peer" "home" {
  comment              = "Managed by Terraform - Home"
  allowed_address      = ["0.0.0.0/0"]
  endpoint_address     = var.wireguard_home_endpoint
  endpoint_port        = 13231
  disabled             = false
  interface            = routeros_interface_wireguard.travel.name
  name                 = "Home"
  persistent_keepalive = null
  preshared_key        = var.wireguard_home_preshared_key
  public_key           = var.wireguard_home_public_key
  is_responder         = "true"
}

# ================================================================================================
# IP Address
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_address
# ================================================================================================
resource "routeros_ip_address" "home" {
  comment   = "Managed by Terraform"
  address   = "10.17.100.5/24"
  interface = routeros_interface_wireguard.travel.name
}


resource "routeros_ip_firewall_nat" "wireguard" {
  comment       = "Managed by Terraform - wireguard masquerade"
  chain         = "srcnat"
  action        = "masquerade"
  out_interface = routeros_interface_wireguard.travel.name
}

resource "routeros_ip_route" "home" {
  dst_address = "10.17.1.0/24"
  gateway     = routeros_interface_wireguard.travel.name
}

