variable "mikrotik_host_url_hap_ac2" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_host_url_hap_lite_tc" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_host_url_wap_r" {
  type        = string
  sensitive   = false
  description = "The URL of the MikroTik device."
}

variable "mikrotik_host_url_rb915ui_2hnd" {
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


## ================================================================================================
## Wireguard Variables
## ================================================================================================
variable "wireguard_home_endpoint" {
  type        = string
  sensitive   = false
  description = "Public endpoint for wireguard server"
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
