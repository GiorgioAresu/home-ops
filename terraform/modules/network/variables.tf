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
