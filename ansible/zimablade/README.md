# Setup zimablade for offsite backups

Edit the truenas_admin account on truenas:

```
SSH Access: true
Public SSH key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJ5kcueMhm6flLiqU7wt+PCaqMk2Mpc7z3MNgy5BNexd
Auxiliary groups: builtin_administrators
Sudo commands:
  - Allow all sudo commands
  - Allow all sudo commands with no password
```

## Allow docker usage for truenas_admin

Add init/shutdown script as such:

```
Description: Add truenas_admin to docker group
Type: Command
Command: sleep 10; usermod -aG docker truenas_admin
When: Post Init
Enabled: true
Timeout: 10
```