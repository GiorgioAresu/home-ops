---
name: add-docker-app
description: Use when deploying or changing an application on the docker hosts (gladius, icarus) — docker-compose stacks under docker/, doco-cd deployments, "deploy X to the NAS", secrets or reverse-proxy wiring for a compose app
---

# Add an App to a Docker Host

Apps live in `docker/<host>/NN-<app>/docker-compose.yaml`, deployed GitOps-style by [doco-cd](https://github.com/kimdre/doco-cd) (config: `docker/<host>/.doco-cd.yaml`): it polls this repo's `main` hourly, auto-discovers stacks one directory deep, and **`delete: true` means removing (or renaming) a directory deletes the running stack**. Mirror an existing app rather than inventing structure:

| Host | Proxy | Network | Reference apps |
|---|---|---|---|
| `truenas` (TrueNAS) | traefik (`01-traefik`, docker provider, `exposedByDefault: false`, wildcard `*.aresu.eu`) | `apps`, or `network_mode: host` | `04-garage` (bind-mount storage), `02-exporters` (host network) |
| `zimablade` (TrueNAS) | traefik (`01-traefik`, docker provider, `exposedByDefault: false`, wildcard `*.paola.aresu.eu`) | `apps`, or `network_mode: host` | `02-exporters` (host network) |
| `odroidhc4` (Armbian) | NONE | `apps`, or `network_mode: host` | `02-exporters` (host network) |

## Steps

1. **Directory**: next free `NN-` prefix on that host (`ls docker/<host>/`). The number is just ordering; keep it stable — renaming triggers delete+recreate.

2. **Compose file** — conventions from existing apps:
   - Top-level `name: <app>` and `container_name: <app>`, `restart: unless-stopped`.
   - Registry-qualified image with a pinned version tag. **Never write a tag from memory** — look up the upstream project's current release first. Plain tags are fine; Renovate manages digests/updates. Keep a `# renovate: datasource=docker depName=...` hint comment only if copying from an app that has one.
   - Set `user:` where the image supports it (see garage).
   - Config files: `config/` subdirectory, wired via a `configs:` block (`04-gatus`) or a read-only bind volume (`03-garage`).
   - Persistent data: on truenas, named volume with `driver_opts` bind to `/mnt/tank/apps/<app>/<vol>` (see garage); on icarus, host path (towonel uses `/opt/<app>`) or a named volume.

3. **Secrets**: add `VAR_NAME: op://<vault>/<item>/<field>` under `external_secrets` in `docker/<host>/.doco-cd.yaml`, reference as `${VAR_NAME}` in the compose file. Use the item's **real field names** (ask the user; never guess) — doco-cd injects these as env vars at deploy time.

4. **Expose it** (only if it serves HTTP):
   - **truenas** and **zimablade**: traefik is label-based, see `03-git`. Confirm the intended exposure with the user instead of inventing label conventions.
   - Only publish `ports:` directly for non-HTTP protocols (see towonel: 22, 51820/udp).

5. **Verify**: `docker compose -f docker/<host>/NN-<app>/docker-compose.yaml config --quiet` (unset `${VAR}` warnings are expected). Show the user the files before committing. Commit style: `feat(<app>): Deploy to NAS`.

## Common mistakes

- **Inventing an image tag** — check the upstream release; a hallucinated tag deploys nothing or the wrong thing.
- **Secret in compose but not in `.doco-cd.yaml`** — the `${VAR}` silently resolves empty.
- **Renaming/renumbering an existing app directory casually** — `delete: true` tears the old stack down, losing anonymous volumes.
