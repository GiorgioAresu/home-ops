resource "routeros_system_user_group" "hapax3_homepage" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "homepage"
  policy   = ["api", "read", "rest-api"]
}
resource "routeros_system_user" "hapax3_homepage" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "homepage"
  group    = routeros_system_user_group.hapax3_homepage.id
  password = "QY3xNQ*vrBeP.fCvostX"
}

resource "routeros_system_user_group" "hapax3_mktxp" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "mktxp"
  policy   = ["api", "read"]
}
resource "routeros_system_user" "hapax3_mktxp" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform"
  name     = "mktxp"
  group    = routeros_system_user_group.hapax3_mktxp.id
  password = "xKM7AMt.3wzWcpmQVipf"
}



