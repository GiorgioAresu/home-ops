# Mikrotik

## VLANs

This caused more pain that I care to admit. What made it click after reading the wiki was [this](https://forum.mikrotik.com/t/bridge-and-port-vlans/125111/8).

## CAPsMAN and VLANs

Manual set up of all the VLANs on each CAPs is required. See [wiki](https://help.mikrotik.com/docs/spaces/ROS/pages/224559120/WiFi#WiFi-CAPsMAN-CAPVLANconfigurationexample%3A).

> :memo: **Note:** The current situation (as of `7.19.3`) with devices using the `wifi-qcom` is that `local_processing=no` (the property itself, thus its effect) is not supported, which means traffic is handled on the CAPs, not CAPsMAN. There's a `traffic-processing=on-capsman` setting that doesn't work. Will keep an eye on changelogs to monitor progress.
