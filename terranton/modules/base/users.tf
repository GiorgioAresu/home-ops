resource "routeros_system_user_group" "homepage" {
  name     = "homepage"
  policy   = ["api", "read", "rest-api"]
}

resource "routeros_system_user" "homepage" {
  name     = "homepage"
  group    = routeros_system_user_group.homepage.id
  password = var.mikrotik_user_homepage_password
}

resource "routeros_system_user_group" "mktxp" {
  name     = "mktxp"
  policy   = ["api", "read"]
}

resource "routeros_system_user" "mktxp" {
  name     = "mktxp"
  group    = routeros_system_user_group.mktxp.id
  password = var.mikrotik_user_mktxp_password
}
