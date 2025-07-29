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
  disabled             = false
  interface            = routeros_interface_wireguard.travel.name
  name                 = "Home"
  persistent_keepalive = null
  preshared_key        = var.wireguard_home_preshared_key
  public_key           = var.wireguard_home_public_key
}
