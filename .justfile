#!/usr/bin/env -S just --justfile

set minimum-version := '1.55.0'

set default-list
set default-script
set lazy
set quiet
set script-interpreter := ['bash', '-euo', 'pipefail']
set shell := ['bash', '-euo', 'pipefail', '-c']

[group: 'k8s-bootstrap']
mod k8s-bootstrap "kubernetes/bootstrap"

[group: 'k8s']
mod k8s "kubernetes"

[group: 'talos']
mod talos "kubernetes/talos"

[group: 'terraform']
mod terraform "terraform"

[private]
log lvl msg *args:
    gum log -t rfc3339 -s -l "{{ lvl }}" "{{ msg }}" {{ args }}

[private]
template file *args:
    minijinja-cli "{{ file }}" {{ args }} | op inject

[group: 'repo']
[doc('Get the list of open PRs in the repository')]
list-prs:
  fjo pr list -R GiorgioAresu/home-ops

[group: 'repo']
[doc('Merge all open PRs in the repository')]
merge-all-prs:
  fjo pr list -R GiorgioAresu/home-ops --jq ".[].number" | xargs -I {} sh -c '
    PR="{}"
    ATTEMPT=1
    MAX_RETRIES=3

    until fjo pr merge "$PR" -R GiorgioAresu/home-ops; do
        if [ $ATTEMPT -ge $MAX_RETRIES ]; then
        echo "❌ PR $PR failed after $MAX_RETRIES attempts. Skipping to the next one..."
        break
        fi
        echo "⚠️ PR $PR not ready (Attempt $ATTEMPT/$MAX_RETRIES). Retrying in 4 seconds..."
        ATTEMPT=$((ATTEMPT + 1))
        sleep 4
    done
    sleep 1
  '