set default-list
set default-script
set quiet
set script-interpreter := ['bash', '-euo', 'pipefail']
set shell := ['bash', '-euo', 'pipefail', '-c']

# ------
# Mikrotik
# ------
[doc('Upgrade Mikrotik RouterOS version')]
mikrotik-upgrade ip:
    ssh {{ ip }} '/system package update check-for-updates once; :delay 3s; :if ([/system/package/update/get status] = "New version is available") do={/system/package/update/install} else={:put "No new version available"}'
