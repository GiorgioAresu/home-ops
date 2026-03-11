resource "routeros_system_routerboard_settings" "rb5009_settings" {
  provider     = routeros.rb5009
  auto_upgrade = true
}

resource "routeros_system_routerboard_settings" "hapax3_settings" {
  provider     = routeros.hAP_ax3
  auto_upgrade = true
}

resource "routeros_system_routerboard_settings" "hapaxlitelte6_settings" {
  provider     = routeros.hAP_ax_lite_LTE6
  auto_upgrade = true
}
