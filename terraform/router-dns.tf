resource "routeros_ip_dns_record" "m5stack_atom_echo" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  type = "A"
  name = "m5stack-atom-echo.iot.aresu.eu"
  address = routeros_ip_dhcp_server_lease.m5stack_atom_echo.address
}
