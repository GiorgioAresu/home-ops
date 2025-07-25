variable "mikrotik_host_url_rb5009" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_host_url_hap_ax3" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_host_url_hap_ax_lite_lte6" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_username" {
  type        = string
  sensitive   = true
  description = "The username for accessing the MikroTik device."
}

variable "mikrotik_password" {
  type        = string
  sensitive   = true
  description = "The password for accessing the MikroTik device."
}

variable "mikrotik_insecure" {
  type        = bool
  default     = true
  description = "Whether to allow insecure connections to the MikroTik device."
}

variable "mikrotik_user_admin" {
  type        = string
  sensitive   = false
  description = "The admin user for accessing the MikroTik device."
}

variable "mikrotik_user_admin_publickey" {
  type        = string
  sensitive   = false
  description = "The SSH public key for accessing the MikroTik device with the admin user."
}

variable "mikrotik_user_homepage_password" {
  type        = string
  sensitive   = true
  description = "homepage user's password"
}

variable "mikrotik_user_mktxp_password" {
  type        = string
  sensitive   = true
  description = "mktxp user's password"
}

variable "mikrotik_user_externaldns_password" {
  type        = string
  sensitive   = true
  description = "externaldns user's password"
}

variable "unifi_api_url" {
  type        = string
  sensitive   = true
  description = "The URL of the UniFi device."
}

variable "unifi_insecure" {
  type        = bool
  default     = true
  description = "Whether to allow insecure connections to the UniFi controller."
}

variable "unifi_username" {
  type        = string
  sensitive   = true
  description = "The username for accessing the UniFi device."
}

variable "unifi_password" {
  type        = string
  sensitive   = true
  description = "The password for accessing the UniFi device."
}


## ================================================================================================
## WiFi Variables
## ================================================================================================
variable "main_wifi_password" {
  type        = string
  sensitive   = true
  description = "The password for the Main Wi-Fi network."
}
variable "guest_wifi_password" {
  type        = string
  sensitive   = true
  description = "The password for the Guest Wi-Fi network."
}
variable "iot_wifi_password" {
  type        = string
  sensitive   = true
  description = "The password for the IoT Wi-Fi network."
}


## ================================================================================================
## Wireguard Variables
## ================================================================================================
variable "wireguard_endpoint" {
  type        = string
  sensitive   = false
  description = "Public endpoint for wireguard server"
}

variable "wireguard_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for wireguard server"
}

variable "wireguard_odroidhc4_preshared_key" {
  type        = string
  sensitive   = true
  description = "Preshared key for OdroidHC4 wireguard client"
}
variable "wireguard_odroidhc4_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for OdroidHC4 wireguard client"
}
variable "wireguard_odroidhc4_public_key" {
  type        = string
  sensitive   = false
  description = "Public key for OdroidHC4 wireguard client"
}
variable "wireguard_phone_giorgio_preshared_key" {
  type        = string
  sensitive   = true
  description = "Preshared key for Giorgio's phone wireguard client"
}
variable "wireguard_phone_giorgio_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for Giorgio's phone wireguard client"
}
variable "wireguard_phone_giorgio_public_key" {
  type        = string
  sensitive   = false
  description = "Public key for Giorgio's phone wireguard client"
}
variable "wireguard_laptop_giorgio_preshared_key" {
  type        = string
  sensitive   = true
  description = "Preshared key for Giorgio's laptop wireguard client"
}
variable "wireguard_laptop_giorgio_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for Giorgio's laptop wireguard client"
}
variable "wireguard_laptop_giorgio_public_key" {
  type        = string
  sensitive   = false
  description = "Public key for Giorgio's laptop wireguard client"
}
variable "wireguard_phone_sara_preshared_key" {
  type        = string
  sensitive   = true
  description = "Preshared key for Sara's phone wireguard client"
}
variable "wireguard_phone_sara_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for Sara's phone wireguard client"
}
variable "wireguard_phone_sara_public_key" {
  type        = string
  sensitive   = false
  description = "Public key for Sara's phone wireguard client"
}
variable "wireguard_travel_router_preshared_key" {
  type        = string
  sensitive   = true
  description = "Preshared key for travel router wireguard client"
}
variable "wireguard_travel_router_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for travel router wireguard client"
}
variable "wireguard_travel_router_public_key" {
  type        = string
  sensitive   = false
  description = "Public key for travel router wireguard client"
}
