# Travel-Router

This module contains the configuration for the travel router, currently a Mikrotik hAP lite.

```shell
terraform apply -target=module.mikrotik_travel_router
```

## Initial setup

If starting from scratch, export the certs from an existing one:

#TODO: fix this
```
/certificate
export name=AresuCA file-name=AresuCA.crt passphrase=12345678
```


Then download the files and upload them to the new one and run:
```
/certificate
import name=AresuCA file-name=AresuCA.crt passphrase=12345678
import name=AresuCA file-name=AresuCA.key passphrase=12345678

/ip/service
set ftp disabled=yes
set telnet disabled=yes
set www disabled=yes
set www-ssl certificate=AresuCA disabled=no tls-version=only-1.2
set api disabled=yes
set api-ssl certificate=AresuCA tls-version=only-1.2

/user/group
add name=terraform policy=read,write,policy,api,rest-api,!local,!telnet,!ssh,!ftp,!reboot,!test,!winbox,!password,!web,!sniff,!sensitive,!romon

/user # Add passwords to the commands, then uncomment the disable command
add group=full name=mikro password=
add group=terraform name=terraform password=
# disable [find name=admin]

/system identity
set name="hAP lite"

# If it works without the bridge (just adding the address to ether2) this could be simplified
/bridge
add name=temp
/bridge/ports
add port=ether2 bridge=temp

/ip/addresses
add address=10.17.4.1/24 network=10.17.4.0 interface=temp
```

Plug the cable to the 2nd port, assign a static 10.17.4.x IP to the machine you're connecting from, and apply the terraform configuration, then delete the bridge, port and IP:

```
/bridge/ports
remove [find bridge=temp]

/ip/addresses
remove [find interface=temp]

/bridge
remove [find name=temp]
```
