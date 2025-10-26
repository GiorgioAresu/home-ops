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
  name        = "wg-home"
  private_key = var.wireguard_home_private_key
}
resource "routeros_interface_wireguard" "vpn_exit" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform - Proton VPN"
  disabled    = false
  listen_port = 12345
  mtu         = "1420"
  name        = "wg-proton"
  private_key = var.wireguard_proton_private_key
}

output "wireguard_public_key" {
  value = routeros_interface_wireguard.home.public_key
}

resource "routeros_ip_address" "wireguard" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  address   = "10.17.100.1/24"
  interface = routeros_interface_wireguard.home.name
  network   = "10.17.100.0"
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
  client_endpoint      = var.wireguard_home_endpoint
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
  client_endpoint      = var.wireguard_home_endpoint
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
  client_endpoint      = var.wireguard_home_endpoint
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
  comment              = "Managed by Terraform - Pixel 9A"
  allowed_address      = ["10.17.100.3/32"]
  client_address       = "10.17.100.3/32"
  client_dns           = "10.17.100.1"
  client_endpoint      = var.wireguard_home_endpoint
  client_keepalive     = null
  client_listen_port   = null
  disabled             = false
  interface            = routeros_interface_wireguard.home.name
  name                 = "Pixel9A"
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
  client_endpoint      = var.wireguard_home_endpoint
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
resource "routeros_interface_wireguard_peer" "proton_vpn" {
  provider             = routeros.rb5009
  comment              = "Managed by Terraform - Proton VPN"
  allowed_address      = ["0.0.0.0/0"]
  endpoint_address     = var.wireguard_proton_endpoint
  endpoint_port        = var.wireguard_proton_port
  disabled             = false
  interface            = routeros_interface_wireguard.vpn_exit.name
  name                 = "ProtonVPN"
  persistent_keepalive = "25s"
  public_key           = var.wireguard_proton_public_key
}
