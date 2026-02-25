resource "routeros_system_script" "notify_vpn_exit_down" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - Notify VPN Exit link is down"
  name     = "notify_vpn_exit_down"
  source   = <<-EOF
    :local peerId "${routeros_interface_wireguard_peer.proton_vpn.id}"

    # Do not refactor the get command, it doesn't work when assigned to a variable
    :put ("Last handshake: " . [/interface/wireguard/peers get $peerId last-handshake])
    :log info ("Last handshake: " . [/interface/wireguard/peers get $peerId last-handshake])

    :if ([/interface/wireguard/peers get $peerId last-handshake] > 6h) do={
      :put "VPN exit is down, switch server"
      :log info "VPN exit is down, switch server"
    } else={
      :put "VPN exit is up, nothing to do"
      :log info "VPN exit is up, nothing to do"
    }
    EOF
  policy   = ["read"]
}

resource "routeros_system_scheduler" "notify_vpn_exit_down" {
  provider = routeros.rb5009
  name     = "notify_vpn_exit_down"
  comment  = "Managed by Terraform - Notify VPN Exit link is down"
  interval = "1h"
  on_event = routeros_system_script.notify_vpn_exit_down.name
  policy   = ["read"]
}
