# =================================================================================================
# Wireguard
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_wireguard
# =================================================================================================
resource "routeros_interface_wireguard" "home" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Home"
  disabled    = false
  listen_port = 13231
  mtu         = "1420"
  name        = "wireguard"
  # private_key = var.wireguard_private_key
}


# =================================================================================================
# Wireguard Peer
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/interface_wireguard_peer
# =================================================================================================
resource "routeros_interface_wireguard_peer" "odroidhc4" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - Odroid HC4"
  allowed_address      = ["10.17.100.50/32"]
  client_address       = "10.17.100.50/32"
  client_dns           = "10.17.100.1"
  client_endpoint      = var.wireguard_endpoint
  client_keepalive     = "30s"
  client_listen_port   = null
  disabled             = false
  interface            = routeros_interface_wireguard.home.name
  name                 = "OdroidHC4"
  persistent_keepalive = "30s"
  preshared_key        = var.wireguard_odroidhc4_preshared_key
  private_key          = var.wireguard_odroidhc4_private_key
  public_key           = var.wireguard_odroidhc4_public_key
}
resource "routeros_interface_wireguard_peer" "phone_giorgio" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - Pixel 7"
  allowed_address      = ["10.17.100.2/32"]
  client_address       = "10.17.100.2/32"
  client_dns           = "10.17.100.1"
  client_endpoint      = var.wireguard_endpoint
  client_keepalive     = null
  client_listen_port   = null
  disabled             = false
  interface            = routeros_interface_wireguard.home.name
  name                 = "Pixel7"
  persistent_keepalive = null
  preshared_key        = var.wireguard_phone_giorgio_preshared_key
  private_key          = var.wireguard_phone_giorgio_private_key
  public_key           = var.wireguard_phone_giorgio_public_key
}
resource "routeros_interface_wireguard_peer" "laptop_giorgio" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - Framework"
  allowed_address      = ["10.17.100.4/32"]
  client_address       = "10.17.100.4/32"
  client_dns           = "10.17.100.1"
  client_endpoint      = var.wireguard_endpoint
  client_keepalive     = null
  client_listen_port   = null
  disabled             = false
  interface            = routeros_interface_wireguard.home.name
  name                 = "Framework"
  persistent_keepalive = null
  preshared_key        = var.wireguard_laptop_giorgio_preshared_key
  private_key          = var.wireguard_laptop_giorgio_private_key
  public_key           = var.wireguard_laptop_giorgio_public_key
}
resource "routeros_interface_wireguard_peer" "phone_sara" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - Pixel 6A"
  allowed_address      = ["10.17.100.3/32"]
  client_address       = "10.17.100.3/32"
  client_dns           = "10.17.100.1"
  client_endpoint      = var.wireguard_endpoint
  client_keepalive     = null
  client_listen_port   = null
  disabled             = false
  interface            = routeros_interface_wireguard.home.name
  name                 = "Pixel6A"
  persistent_keepalive = null
  preshared_key        = var.wireguard_phone_sara_preshared_key
  private_key          = var.wireguard_phone_sara_private_key
  public_key           = var.wireguard_phone_sara_public_key
}
resource "routeros_interface_wireguard_peer" "travel_router" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - Travel Router"
  allowed_address      = ["10.17.100.5/32"]
  client_address       = "10.17.100.5/32"
  client_dns           = "10.17.100.1"
  client_endpoint      = var.wireguard_endpoint
  client_keepalive     = null
  client_listen_port   = null
  disabled             = false
  interface            = routeros_interface_wireguard.home.name
  name                 = "TravelRouter"
  persistent_keepalive = null
  preshared_key        = var.wireguard_travel_router_preshared_key
  private_key          = var.wireguard_travel_router_private_key
  public_key           = var.wireguard_travel_router_public_key
}
