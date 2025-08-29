#!/bin/bash
sudo apt update
sudo apt install -y build-essential gcc python3 pipx

pipx ensurepath

pipx install esphome==${ESPHOME_VERSION}
