resource "routeros_ip_firewall_nat" "qbittorrent_tcp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - QBittorrent TCP"
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "tcp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 52015
  to_addresses      = "10.17.1.215"
}
resource "routeros_ip_firewall_nat" "qbittorrent_udp" {
  provider          = routeros.rb5009
  comment           = "Managed by Terraform - QBittorrent UDP"
  action            = "dst-nat"
  chain             = "dstnat"
  protocol          = "udp"
  in_interface_list = routeros_interface_list.wan.name
  dst_port          = 52015
  to_addresses      = "10.17.1.215"
}
