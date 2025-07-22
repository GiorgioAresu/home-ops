###
### BGP
###
# https://www.reddit.com/r/MaksIT/comments/1gak5l8/configuring_ibgp_with_mikrotik_and_kubernetes/

# A BGP template allows the MikroTik router to redistribute connected routes and advertise the default route (0.0.0.0/0) to Kubernetes nodes.
resource "routeros_routing_bgp_template" "home-ops" {
  provider  = routeros.rb5009
  comment   = "Managed by Terraform"
  name      = "home-ops"
  as        = 64501
  router_id = "10.17.1.1"
  output {
    default_originate = "always"
    redistribute      = "connected,static"
  }
}
