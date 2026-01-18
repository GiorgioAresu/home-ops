# ================================================================================================
# File
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/file
# ================================================================================================

# /tool fetch url="https://boot.netboot.xyz/ipxe/netboot.xyz.kpxe"
resource "routeros_file" "netboot_xyz_bios" {
  provider = routeros.rb5009
  name     = "netboot.xyz.kpxe"
}

# /tool fetch url="https://boot.netboot.xyz/ipxe/netboot.xyz.efi"
resource "routeros_file" "netboot_xyz_uefi" {
  provider = routeros.rb5009
  name     = "netboot.xyz.efi"
}

# Do not remove these
import {
  id = "name=netboot.xyz.bios"
  to = routeros_file.netboot_xyz_bios
}
import {
  id = "name=netboot.xyz.efi"
  to = routeros_file.netboot_xyz_uefi
}

# ================================================================================================
# TFTP
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_tftp
# ================================================================================================
resource "routeros_ip_tftp" "netboot_xyz_bios" {
  provider      = routeros.rb5009
  req_filename  = routeros_file.netboot_xyz_bios.name
  real_filename = routeros_file.netboot_xyz_bios.name
  allow         = true
  read_only     = true
}
resource "routeros_ip_tftp" "netboot_xyz_uefi" {
  provider      = routeros.rb5009
  req_filename  = routeros_file.netboot_xyz_uefi.name
  real_filename = routeros_file.netboot_xyz_uefi.name
  allow         = true
  read_only     = true
}
