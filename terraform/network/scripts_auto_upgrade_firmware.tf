resource "routeros_system_script" "rb5009_auto_upgrade_firmware" {
  provider = routeros.rb5009
  comment  = "Managed by Terraform - Auto-upgrade firmware"
  name     = "auto-upgrade-firmware"
  source   = <<-EOT
    :local current [/system routerboard get current-firmware]
    :local upgrade [/system routerboard get upgrade-firmware]
    :if ($current != $upgrade) do={
        :log warning ("auto-upgrade-firmware: upgrading bootloader " . $current . " -> " . $upgrade)
        /system routerboard upgrade
        :delay 3
        /system reboot
    } else={
        :log info ("auto-upgrade-firmware: bootloader already current (" . $current . ")")
    }
    EOT
  policy   = ["read", "write", "policy", "test", "reboot"]
}

resource "routeros_system_scheduler" "rb5009_auto_upgrade_firmware" {
  provider = routeros.rb5009
  name     = "auto-upgrade-firmware"
  on_event = routeros_system_script.rb5009_auto_upgrade_firmware.name
  interval = "0s"
  start_time = "startup"
}


resource "routeros_system_script" "hap_ax_lite_lte6_auto_upgrade_firmware" {
  provider = routeros.hAP_ax_lite_LTE6
  comment  = "Managed by Terraform - Auto-upgrade firmware"
  name     = "auto-upgrade-firmware"
  source   = <<-EOT
    :foreach lteIface in=[/interface lte find] do={
        :local lteName [/interface lte get $lteIface name]
        :if ([/interface lte get $lteIface running]) do={
            :local fw [/interface lte firmware-upgrade $lteIface as-value]
            :if (($fw->"installed") != ($fw->"latest")) do={
                :log warning ("auto-upgrade-firmware: upgrading LTE modem " . $lteName)
                /interface lte firmware-upgrade $lteIface upgrade=yes
                :delay 60s
            }
        }
    }

    :local current [/system routerboard get current-firmware]
    :local upgrade [/system routerboard get upgrade-firmware]
    :if ($current != $upgrade) do={
        :log warning ("auto-upgrade-firmware: upgrading bootloader " . $current . " -> " . $upgrade)
        /system routerboard upgrade
        :delay 3
        /system reboot
    } else={
        :log info ("auto-upgrade-firmware: bootloader already current (" . $current . ")")
    }
    EOT
  policy   = ["read", "write", "policy", "test", "reboot"]
}

resource "routeros_system_scheduler" "hap_ax_lite_lte6_auto_upgrade_firmware" {
  provider = routeros.hAP_ax_lite_LTE6
  name     = "auto-upgrade-firmware"
  on_event = routeros_system_script.hap_ax_lite_lte6_auto_upgrade_firmware.name
  interval = "0s"
  start_time = "startup"
}


resource "routeros_system_script" "wap_ax_auto_upgrade_firmware" {
  provider = routeros.wAP_ax
  comment  = "Managed by Terraform - Auto-upgrade firmware"
  name     = "auto-upgrade-firmware"
  source   = <<-EOT
    :local current [/system routerboard get current-firmware]
    :local upgrade [/system routerboard get upgrade-firmware]
    :if ($current != $upgrade) do={
        :log warning ("auto-upgrade-firmware: upgrading bootloader " . $current . " -> " . $upgrade)
        /system routerboard upgrade
        :delay 3
        /system reboot
    } else={
        :log info ("auto-upgrade-firmware: bootloader already current (" . $current . ")")
    }
    EOT
  policy   = ["read", "write", "policy", "test", "reboot"]
}

resource "routeros_system_scheduler" "wap_ax_auto_upgrade_firmware" {
  provider = routeros.wAP_ax
  name     = "auto-upgrade-firmware"
  on_event = routeros_system_script.wap_ax_auto_upgrade_firmware.name
  interval = "0s"
  start_time = "startup"
}


resource "routeros_system_script" "hap_ax3_auto_upgrade_firmware" {
  provider = routeros.hAP_ax3
  comment  = "Managed by Terraform - Auto-upgrade firmware"
  name     = "auto-upgrade-firmware"
  source   = <<-EOT
    :local current [/system routerboard get current-firmware]
    :local upgrade [/system routerboard get upgrade-firmware]
    :if ($current != $upgrade) do={
        :log warning ("auto-upgrade-firmware: upgrading bootloader " . $current . " -> " . $upgrade)
        /system routerboard upgrade
        :delay 3
        /system reboot
    } else={
        :log info ("auto-upgrade-firmware: bootloader already current (" . $current . ")")
    }
    EOT
  policy   = ["read", "write", "policy", "test", "reboot"]
}

resource "routeros_system_scheduler" "hap_ax3_auto_upgrade_firmware" {
  provider = routeros.hAP_ax3
  name     = "auto-upgrade-firmware"
  on_event = routeros_system_script.hap_ax3_auto_upgrade_firmware.name
  interval = "0s"
  start_time = "startup"
}
