# =================================================================================================
# DNS
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dns
# =================================================================================================
resource "routeros_ip_dns" "dns-server" {
  allow_remote_requests = true
  cache_size            = 2048
  cache_max_ttl         = "2d"
  servers = [
    "1.1.1.1",
    "1.0.0.1"
  ]
}

# =================================================================================================
# DNS AdList
# https://registry.terraform.io/providers/terraform-routeros/routeros/latest/docs/resources/ip_dns_adlist
# =================================================================================================
# Not enough cpu/ram to run stevenblacks
resource "routeros_ip_dns_adlist" "adaway" {
  disabled   = true
  url        = "https://adaway.org/hosts.txt"
  ssl_verify = false
}
