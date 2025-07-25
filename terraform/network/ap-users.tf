resource "routeros_system_user_group" "hapax3_homepage" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "homepage"
  policy   = ["api", "read", "rest-api"]
}
resource "routeros_system_user_group" "hapaxlitelte6_homepage" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "homepage"
  policy   = ["api", "read", "rest-api"]
}

resource "routeros_system_user" "hapax3_homepage" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "homepage"
  group    = routeros_system_user_group.hapax3_homepage.name
  password = var.mikrotik_user_homepage_password
}
resource "routeros_system_user" "hapaxlitelte6_homepage" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "homepage"
  group    = routeros_system_user_group.hapaxlitelte6_homepage.name
  password = var.mikrotik_user_homepage_password
}

resource "routeros_system_user_group" "hapax3_mktxp" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "mktxp"
  policy   = ["api", "read"]
}
resource "routeros_system_user_group" "hapaxlitelte6_mktxp" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "mktxp"
  policy   = ["api", "read"]
}

resource "routeros_system_user" "hapax3_mktxp" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "mktxp"
  group    = routeros_system_user_group.hapax3_mktxp.name
  password = var.mikrotik_user_mktxp_password
  address  = "10.17.1.34/32,10.17.1.36/32,10.17.1.37/32,10.17.1.38/32" # TODO: Refactor this
}
resource "routeros_system_user" "hapaxlitelte6_mktxp" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "mktxp"
  group    = routeros_system_user_group.hapaxlitelte6_mktxp.name
  password = var.mikrotik_user_mktxp_password
  address  = "10.17.1.34/32,10.17.1.36/32,10.17.1.37/32,10.17.1.38/32" # TODO: Refactor this
}

resource "routeros_system_user_group" "hapax3_terraform" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "terraform"
  policy   = ["api", "policy", "read", "rest-api", "sensitive", "test", "write"]
}
resource "routeros_system_user_group" "hapaxlitelte6_terraform" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "terraform"
  policy   = ["api", "policy", "read", "rest-api", "sensitive", "test", "write"]
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
