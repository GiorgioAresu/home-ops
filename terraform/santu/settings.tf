resource "routeros_system_routerboard_settings" "hap_ac2_settings" {
  provider     = routeros.hap_ac2
  auto_upgrade = true
}

resource "routeros_system_routerboard_settings" "hap_lite_tc_settings" {
  provider     = routeros.hAP_lite_TC
  auto_upgrade = true
}

resource "routeros_system_routerboard_settings" "wap_r_settings" {
  provider     = routeros.wAP_R
  auto_upgrade = true
}

resource "routeros_system_routerboard_settings" "rB915Ui_2HnD_settings" {
  provider     = routeros.rB915Ui_2HnD
  auto_upgrade = true
}
