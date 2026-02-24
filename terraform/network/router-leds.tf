resource "routeros_system_led" "rb5009_user" {
  provider = routeros.rb5009
  disabled = "true"
  leds     = ["user-led"]
  type     = "on"
}

