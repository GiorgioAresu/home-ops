# Setup odroidhc4 for offline backups

Create the odroid account, make sure ssh key is copied, make sure the headers are installed for the kernel version you're running, freeze the kernel and pray that Armbian doesn't mess it up as it's known to. This could be automated at some point. Worst case, remove the apt repo

## Install and setup docker

```shell
armbian-config --cmd CON001
```
