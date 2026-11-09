resource "routeros_system_user_group" "hapax3_terraform" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "terraform"
  policy   = ["api", "policy", "read", "rest-api", "sensitive", "test", "reboot", "write"]
}
resource "routeros_system_user_group" "hapaxlitelte6_terraform" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "terraform"
  policy   = ["api", "policy", "read", "rest-api", "sensitive", "test", "reboot", "write"]
}
resource "routeros_system_user_group" "wapax_terraform" {
  provider = routeros.wAP_ax
  comment  = "Managed by Terraform"
  name     = "terraform"
  policy   = ["api", "policy", "read", "rest-api", "sensitive", "test", "reboot", "write"]
}
import {
  id = "*4"
  to = routeros_system_user_group.wapax_terraform
}

resource "routeros_system_user" "hapax3_terraform" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "terraform"
  group    = routeros_system_user_group.hapax3_terraform.name
  password = var.mikrotik_password
}
resource "routeros_system_user" "hapaxlitelte6_terraform" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "terraform"
  group    = routeros_system_user_group.hapaxlitelte6_terraform.name
  password = var.mikrotik_password
}
resource "routeros_system_user" "wapax_terraform" {
  provider = routeros.wAP_ax
  comment  = "Managed by Terraform"
  name     = "terraform"
  group    = routeros_system_user_group.wapax_terraform.name
  password = var.mikrotik_password
}
import {
  id = "*3" # TODO: After reset and following MIKROTIK.md this will always be *1
  to = routeros_system_user.wapax_terraform
}


resource "routeros_system_user_sshkeys" "hapax3_terraform" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  user     = var.mikrotik_user_admin
  key      = var.mikrotik_user_admin_publickey
}
resource "routeros_system_user_sshkeys" "hapaxlitelte6_terraform" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  user     = var.mikrotik_user_admin
  key      = var.mikrotik_user_admin_publickey
}
resource "routeros_system_user_sshkeys" "wapax_terraform" {
  provider = routeros.wAP_ax
  comment  = "Managed by Terraform"
  user     = var.mikrotik_user_admin
  key      = var.mikrotik_user_admin_publickey
}
