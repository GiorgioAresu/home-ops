# K8s cluster


The main idea was to have a cheap-ish yet reliable cluster to:
- Self-host various applications.
- Learn gitops.
- Practice after CKAD outside of work (free to explore new interesting stuff and do things by the book).

The desiderata was for it to be as self-contained as possible to allow the main storage server to be shut down if needed (to save power and keep noise down). A small number of applications will still rely on it, be it due to the larger available size or for data accessibility and reliability reasons.

The end result is currently an *amd64* cluster¹, with every node running [Talos](https://www.talos.dev/) and participating in the Control Plane.

## 🛠️ Hardware

| #  | Device               | Cores (Threads) | Memory | Disk      |
|----|----------------------|-----------------|--------|-----------|
| 1x | BMAX B4+ N100        | 4               | 16GB   | 512GB SSD |
| 1x | MINISFORUM UH125 Pro | 14 (18)         | 32GB   | 1TB SSD   |
| 1x | Proxmox VM           | 4               | 24GB   | 300GB SSD |

## 🖥️ Node setup

Boot the Talos image. DHCP static mappings FTW to avoid static IPs being spread in different configurations.

```shell
task talos:generate-clusterconfig # Generates individual talos config files for each node
task k8s-bootstrap:talos # Bootstrap nodes from configuration, installing it on disk. Nodes won't be in a ready state after this, so move on
task k8s-bootstrap:apps # Bootstrap applications: basic system (ie. networking) stuff and flux, which then will install everything else
```

---
---
## 🚧🚧🚧 WIP

Everything after this is old stuff, yet to be revised. This probably doesn't reflect the current setup.

## Additional steps

```shell
ansible -i inventory/my-cluster/hosts.ini k3s_cluster -m apt -a "pkg=curl,nfs-common,open-iscsi" --become
```


## Workstation setup

The following needs to be done on your PC


### Requirements

Install:

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [flux2](https://fluxcd.io/docs/installation/#install-the-flux-cli)


### Get kube config

```shell
scp ubuntu@kube-master-p1:~/.kube/config ~/.kube/config
```


## Flux

Get an Personal Access Token from [GitHub](https://github.com/settings/tokens) and set the envs accordingly, then bootstrap flux:

```shell
export GITHUB_USER=GiorgioAresu
export GITHUB_TOKEN=new-token
flux bootstrap github \
  --owner=GiorgioAresu \
  --repository=homelab-gitops \
  --path=cluster/base \
  --personal
```

## Volume backups

When creating new volumes, you can add them to a group for automatic backup.
Longhorn is configured to perform automatic snapshots and backups for Volumes labeled with `recurring-job-group.longhorn.io/backup=enabled`.

If you're creating a new Volume, you can label it (**NOT** the PersistentVolume):

```shell
kubectl -n longhorn-system label volume {volume-name} recurring-job-group.longhorn.io/default- recurring-job-group.longhorn.io/backup=enabled
```

You can use something like this to do it in bulk:

```shell
# This will label all Volumes named like plex-config-v1, you may want to double-check not to miss any important one
kubectl -n longhorn-system get volume -o name | cut -d/ -f2 | grep -E '([[:alnum:]]+-)+[[:alpha:]]+-v[[:digit:]]+' | xargs -i kubectl -n longhorn-system label volume {} recurring-job-group.longhorn.io/default- recurring-job-group.longhorn.io/backup=enabled
```

## Application-specific documentation

See [apps folder](./apps/) for documentation/guides regarding specific application.
