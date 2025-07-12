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
  group    = routeros_system_user_group.hapax3_homepage.id
  password = var.mikrotik_user_homepage_password
}
resource "routeros_system_user" "hapaxlitelte6_homepage" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "homepage"
  group    = routeros_system_user_group.hapaxlitelte6_homepage.id
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
  group    = routeros_system_user_group.hapax3_mktxp.id
  password = var.mikrotik_user_mktxp_password
  address  = "10.17.1.34/32,10.17.1.36/32,10.17.1.37/32,10.17.1.38/32" # TODO: Refactor this
}
resource "routeros_system_user" "hapaxlitelte6_mktxp" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform"
  name     = "mktxp"
  group    = routeros_system_user_group.hapax3_mktxp.id
  password = var.mikrotik_user_mktxp_password
  address  = "10.17.1.34/32,10.17.1.36/32,10.17.1.37/32,10.17.1.38/32" # TODO: Refactor this
}
