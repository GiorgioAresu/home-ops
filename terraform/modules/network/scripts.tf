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
