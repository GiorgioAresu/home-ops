# Install

Armbian stable (debian trixie)

Configure armbian
armbian-config --cmd HEAD01 # Install headers (if fails, check linux-headers-* version and downgrade kernel to that https://docs.armbian.com/User-Guide_Advanced-Configuration/#switch-or-downgrade-kernels)
armbian-config --cmd CON002 # docker full
armbian-config --cmd WRG002 # wireguard client (will ask for ROUTES TO FORWARD THROUGH VPN), paste config from mikrotik and set 10.17.100.0/24

install packages
sudo apt install zfs-dkms git build-essentials

install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
when successful
    echo >> /home/odroid/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/odroid/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"


brew install gcc sops age
