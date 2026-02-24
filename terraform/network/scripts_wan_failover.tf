resource "routeros_system_script" "wan_failover" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - Toggle WAN failover to backup link"
  name     = "wan_failover"
  source   = <<-EOF
    :local mainInterface "ether1"
    :local backupInterface "lte"

    :local blink do={
      :local led [/system/leds find leds="sfp-sfpplus1-led"]
      :for i from=1 to=4 do={
        /system/leds set $led type=on
        :delay 0.5s
        /system/leds set $led type=off
        :delay 0.5s
      }
      /system/leds set $led type=interface-activity
    }

    :put "Testing route..."
    :local currentRoute [/ip/route/check dst-ip=1.1.1.1 as-value once proplist=interface]
    :if ($currentRoute = "interface=$mainInterface") do={
      :put "On main link, switching to backup"
      :log info "On main link, switching to backup"
      $blink
      /system/leds enable [find leds="user-led"]
      /ip/dhcp-client enable [find interface=$backupInterface]
      /ip/dhcp-client disable [find interface=$mainInterface]
    } else={
      :put "On backup link, switching to main"
      :log info "On backup link, switching to main"
      /ip/dhcp-client enable [find interface=$mainInterface]
      /ip/dhcp-client disable [find interface=$backupInterface]
      $blink
      /system/leds disable [find leds="user-led"]
    }
    EOF
  policy   = ["read", "write", "test"]
}

resource "routeros_system_routerboard_button_reset" "wan_failover" {
  provider  = routeros.rb5009
  enabled   = true
  hold_time = "1s..5s"
  on_event  = routeros_system_script.wan_failover.name
}
