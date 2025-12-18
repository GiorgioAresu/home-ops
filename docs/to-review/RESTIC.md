# Restic

Install restic and resticprofile

## Init a restic repo for a new application

Create a `profiles.yaml` for restic:
```yaml
---
version: "1"

default:
  password-file: pw
  repository: "sftp:root@truenas.aresu.eu:/mnt/tank/backups/volsync/{{ .Env.REPO }}"
  initialize: true

  backup:
    source: "{{ .Env.SOURCE }}"
```

then just use resticprofile as you would, eg.
REPO=syncthing-config SOURCE=sync resticprofile backup
REPO=syncthing-config SOURCE=sync resticprofile snapshots
REPO=syncthing-config SOURCE=sync resticprofile list snapshots
REPO=syncthing-config bin/resticprofile forget --keep-last 1 --prune
