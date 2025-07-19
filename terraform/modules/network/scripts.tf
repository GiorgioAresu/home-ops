resource "routeros_system_led" "rb5009_user" {
  provider = routeros.rb5009
  disabled = "true"
  leds     = ["user-led"]
  type     = "on"
}

resource "routeros_system_script" "wan_failover" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - Toggle WAN failover to backup link"
  name     = "wan_failover"
  source   = <<-EOF
    :local mainInterface "ether1"

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
      /ip/dhcp-client disable [find interface=$mainInterface]
    } else={
      :put "On backup link, switching to main"
      :log info "On backup link, switching to main"
      /ip/dhcp-client enable [find interface=$mainInterface]
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

resource "routeros_system_script" "hap_ax3_dark_mode" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform - Toggle leds dark mode"
  name     = "dark_mode"
  source   = <<-EOF
    :local current [/system/leds/settings get all-leds-off]
    :local target
    :if ($current = "never") do={ :set target "immediate" } else={ :set target "never" }
    :log info "[LED state] Current: $current - Target: $target"
    /system/leds/settings set all-leds-off=$target
    EOF
  policy   = ["read", "write"]
}

resource "routeros_system_routerboard_button_wps" "hap_ax3_dark_mode" {
  provider = routeros.hAP_ax3
  enabled  = true
  on_event = routeros_system_script.hap_ax3_dark_mode.name
}
