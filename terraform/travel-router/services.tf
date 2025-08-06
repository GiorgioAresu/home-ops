resource "routeros_ip_neighbor_discovery_settings" "settings" {
  discover_interface_list  = routeros_interface_list.lan.name
  mode                     = "tx-and-rx"
  protocol                 = ["cdp", "lldp", "mndp"]
}
