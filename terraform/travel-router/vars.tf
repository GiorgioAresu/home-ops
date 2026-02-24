## ================================================================================================
## Mikrotik Variables
## ================================================================================================
variable "mikrotik_host_url" {
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


## ================================================================================================
## WiFi Variables
## ================================================================================================
variable "main_wifi_password" {
  type        = string
  sensitive   = true
  description = "The password for the Main Wi-Fi network."
}

variable "bridge_wifi_password" {
  type        = string
  sensitive   = true
  description = "The password for the bridge Wi-Fi network."
}

variable "travel_wifi_password" {
  type        = string
  sensitive   = true
  description = "The password for the Travel Wi-Fi network."
}

variable "wifi_station_cloned_mac" {
  type        = string
  sensitive   = false
  description = "MAC to spoof, if any. Used to hijack another device auth in hotel networks"
}


## ================================================================================================
## Wireguard Variables
## ================================================================================================
variable "wireguard_private_key" {
  type        = string
  sensitive   = true
  description = "Private key for wireguard server"
}

variable "wireguard_home_endpoint" {
  type        = string
  sensitive   = false
  description = "Public endpoint for home wireguard server"
}

variable "wireguard_home_preshared_key" {
  type        = string
  sensitive   = true
  description = "Preshared key for home wireguard server"
}

variable "wireguard_home_public_key" {
  type        = string
  sensitive   = false
  description = "Public key for home wireguard server"
}

variable "known_wifis" {
  description = "List of known WiFi networks with passwords. Leave password empty for open networks"
  type = list(object({
    comment     = string
    ssid        = string
    password    = string
    enabled     = optional(bool)
    mac_address = optional(string)
  }))
}
