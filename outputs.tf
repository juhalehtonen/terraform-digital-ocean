# Define output variables to be displayed after creation
# Terraform does not output outputs that are not produced,
# so one can safely include a bunch here and Terraform only
# shows the relevant ones in the end.

# Droplet(s)
# Note that there can be X number of Droplets, so we need to join
# the output values together to get a list of all of them.
output "Droplet_addresses" {
  value = "${join(", ", digitalocean_droplet.web.*.ipv4_address)}"
}

output "Droplet_names" {
  value = "${join(", ", digitalocean_droplet.web.*.name)}"
}

output "Droplet_sizes" {
  value = "${join(", ", digitalocean_droplet.web.*.size)}"
}

output "Droplet_regions" {
  value = "${join(", ", digitalocean_droplet.web.*.region)}"
}

output "Droplet_monthly_prices" {
  value = "${join(", ", digitalocean_droplet.web.*.price_monthly)}"
}

output "Droplet_statuses" {
  value = "${join(", ", digitalocean_droplet.web.*.status)}"
}


# Domain
output "Domain_droplet" {
    value = "${digitalocean_domain.domain.id}"
}
output "Domain_load_balancer" {
    value = "${digitalocean_domain.domain_lb.id}"
}
output "Domain_floating_ip" {
    value = "${digitalocean_domain.domain_fip.id}"
}


# Floating IP
output "Floating_IP_address" {
    value = "${digitalocean_floating_ip.web_fip.ip_address}"
}


# Load Balancer
output "Load_balancer_IP" {
  value = "${digitalocean_loadbalancer.web_lb.ip}"
}
