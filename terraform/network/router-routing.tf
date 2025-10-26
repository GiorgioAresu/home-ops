###
### BGP
###
# A BGP template allows the MikroTik router to redistribute connected routes and advertise the default route (0.0.0.0/0) to Kubernetes nodes.
resource "routeros_routing_bgp_template" "home_ops" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform - Kubernetes cluster"
  name      = "home-ops"
  as        = local.bgp_as_local
  hold_time = "1h30m"
}

resource "routeros_routing_filter_rule" "home_ops_in" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  chain    = "bgp-in"
  rule     = "accept"
}

resource "routeros_routing_filter_rule" "home_ops_out" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform"
  chain    = "bgp-out"
  rule     = "if (dst in 10.17.1.0/24 or dst in 10.1.1.0/24) { accept } else { reject }"
}

resource "routeros_routing_bgp_connection" "home_ops_kube_proxmox_01" {
  provider       = routeros.rb5009
  comment        = "Managed by Terraform - kube-proxmox-01"
  name           = "cilium-bgp"
  as             = local.bgp_as_local
  listen         = true
  nexthop_choice = "force-self"
  router_id      = "10.17.1.1"
  routing_table  = "main"
  templates      = [routeros_routing_bgp_template.home_ops.name]

  input {
    filter = routeros_routing_filter_rule.home_ops_in.chain
  }
  output {
    filter_chain = routeros_routing_filter_rule.home_ops_out.chain
  }
  local {
    role = "ebgp"
  }
  remote {
    address = routeros_ip_dhcp_server_lease.kube_proxmox_01.address
    as      = local.bgp_as_remote_kubernetes
  }
}

resource "routeros_routing_bgp_connection" "home_ops_kube_minisforum_01" {
  provider       = routeros.rb5009
  comment        = "Managed by Terraform - kube-minisforum-01"
  name           = "cilium-bgp"
  as             = local.bgp_as_local
  listen         = true
  nexthop_choice = "force-self"
  router_id      = "10.17.1.1"
  routing_table  = "main"
  templates      = [routeros_routing_bgp_template.home_ops.name]

  input {
    filter = routeros_routing_filter_rule.home_ops_in.chain
  }
  output {
    filter_chain = routeros_routing_filter_rule.home_ops_out.chain
  }
  local {
    role = "ebgp"
  }
  remote {
    address = routeros_ip_dhcp_server_lease.minisforum_uh125_pro.address
    as      = local.bgp_as_remote_kubernetes
  }
}

resource "routeros_routing_bgp_connection" "home_ops_kube_bmax_b4_plus" {
  provider       = routeros.rb5009
  comment        = "Managed by Terraform - kube-bmax-b4-plus"
  name           = "cilium-bgp"
  as             = local.bgp_as_local
  listen         = true
  nexthop_choice = "force-self"
  router_id      = "10.17.1.1"
  routing_table  = "main"
  templates      = [routeros_routing_bgp_template.home_ops.name]

  input {
    filter = routeros_routing_filter_rule.home_ops_in.chain
  }
  output {
    filter_chain = routeros_routing_filter_rule.home_ops_out.chain
  }
  local {
    role = "ebgp"
  }
  remote {
    address = routeros_ip_dhcp_server_lease.bmax_b4_plus.address
    as      = local.bgp_as_remote_kubernetes
  }
}

resource "routeros_routing_table" "vpn_exit_table" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - Routing via VPN Exit"
  name     = "vpn_exit"
  fib      = true
}

resource "routeros_routing_rule" "vpn_exit" {
  provider    = routeros.rb5009
  comment     = "Managed by Terraform"
  dst_address = "0.0.0.0/0"
  action      = "lookup-only-in-table"
  interface   = routeros_interface_vlan.vpn_exit.name
  table       = routeros_routing_table.vpn_exit_table.name
}
resource "routeros_ip_route" "vpn_exit_wg_endpoint" {
  provider      = routeros.rb5009
  comment       = "Managed by Terraform - Force wireguard server endpoint through WAN"
  dst_address   = "${var.wireguard_proton_endpoint}/32"
  gateway       = routeros_interface_ethernet.rb5009_ether1.name
  routing_table = routeros_routing_table.vpn_exit_table.name
}
resource "routeros_ip_route" "vpn_exit_default_route" {
  provider      = routeros.rb5009
  comment       = "Managed by Terraform - Everything else through the VPN Exit interface"
  dst_address   = "0.0.0.0/0"
  gateway       = routeros_interface_wireguard.vpn_exit.name
  routing_table = routeros_routing_table.vpn_exit_table.name
}

