resource "routeros_system_user_group" "terraform" {
  comment = "Managed by Terraform"
  name    = "terraform"
  policy  = ["api", "policy", "read", "rest-api", "sensitive", "test", "write"]
}

resource "routeros_system_user" "terraform" {
  comment  = "Managed by Terraform"
  name     = "terraform"
  group    = routeros_system_user_group.terraform.name
  password = var.mikrotik_password
}

resource "routeros_system_user_sshkeys" "terraform" {
  comment = "Managed by Terraform"
  user    = var.mikrotik_user_admin
  key     = var.mikrotik_user_admin_publickey
}
