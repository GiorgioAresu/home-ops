# Mikrotik

## VLANs

This caused more pain that I care to admit. What made it click after reading the wiki was [this](https://forum.mikrotik.com/t/bridge-and-port-vlans/125111/8).

## CAPsMAN and VLANs

Manual set up of all the VLANs on each CAPs is required. See [wiki](https://help.mikrotik.com/docs/spaces/ROS/pages/224559120/WiFi#WiFi-CAPsMAN-CAPVLANconfigurationexample%3A).

> :memo: **Note:** The current situation (as of `7.19.3`) with devices using the `wifi-qcom` is that `local_processing=no` (the property itself, thus its effect) is not supported, which means traffic is handled on the CAPs, not CAPsMAN. There's a `traffic-processing=on-capsman` setting that doesn't work. Will keep an eye on changelogs to monitor progress.

## Bulk updates

To update a device from an external host, make sure ssh is set up with certs, then run:

```shell
export HOST=10.17.1.x

echo "-> Updating software..."
ssh $HOST /system/package/update/check-for-updates
ssh $HOST /system/package/update/download
echo "-> Rebooting..."
ssh $HOST reboot
sleep 1
until nc -z $HOST 22
do
    echo "-> Waiting for the device to come back online..."
    sleep 1
done
echo "-> Done. Updating firmware..."
ssh $HOST /system/routerboard/upgrade
echo "-> Rebooting..."
ssh $HOST reboot
sleep 1
until nc -z $HOST 22
do
    echo "-> Waiting for the device to come back online..."
    sleep 1
done
echo "-> Done."
```

## Base configs

This section contains some configuration pieces to get devices started for use with the terraform configurations contained in this module. Replace the `${variable}` as appropriate.

### Initial setup:

Get the certificates.

You can export them from an existing device, if you have access to them, with the following command. Note that providing a passphrase is necessary for the `.key` to be exported along the `.crt`:

```shell
export-certificate [find name=AresuCA] file-name=AresuCA export-passphrase=${passphrase}
```

Then log into the new one, reset without the initial configuration and do:

```shell
/certificate
import name=AresuCA file-name=AresuCA.crt passphrase=${passphrase}
import name=AresuCA file-name=AresuCA.key passphrase=${passphrase}

/ip/service
set ftp disabled=yes
set telnet disabled=yes
set www disabled=yes
set www-ssl certificate=AresuCA disabled=no tls-version=only-1.2
set api disabled=yes
set api-ssl certificate=AresuCA tls-version=only-1.2

/user/group
add name=terraform policy=read,write,policy,api,rest-api,!local,!telnet,!ssh,!ftp,!reboot,!test,!winbox,!password,!web,!sniff,!sensitive,!romon

/user
add group=full name=mikro password=${mikro_pw}
add group=terraform name=terraform password=${tf_pw}
disable [find name=admin]
```

### Travel Router

Add to the initial setup:

```shell
/system identity
set name="hAP lite"

/bridge
add name=local
/bridge/ports
add port=ether2 bridge=local

/ip/addresses
add address=10.17.4.1/24 network=10.17.4.0
```
