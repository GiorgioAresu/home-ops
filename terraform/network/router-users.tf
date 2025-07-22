resource "routeros_system_user_group" "homepage" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "homepage"
  policy   = ["api", "read", "rest-api"]
}

resource "routeros_system_user" "homepage" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "homepage"
  group    = routeros_system_user_group.homepage.name
  password = var.mikrotik_user_homepage_password
}

resource "routeros_system_user_group" "mktxp" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "mktxp"
  policy   = ["api", "read"]
}

resource "routeros_system_user" "mktxp" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "mktxp"
  group    = routeros_system_user_group.mktxp.name
  password = var.mikrotik_user_mktxp_password
  address  = "10.17.1.34/32,10.17.1.36/32,10.17.1.37/32,10.17.1.38/32" # TODO: Refactor this
}

resource "routeros_system_user_group" "external_dns" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "external_dns"
  policy   = ["api", "read", "rest-api", "write"]
}

resource "routeros_system_user" "external_dns" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  name     = "external_dns"
  group    = routeros_system_user_group.external_dns.name
  password = var.mikrotik_user_externaldns_password
}
