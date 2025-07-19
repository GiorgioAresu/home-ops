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
