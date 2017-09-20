# Define output variables to be displayed after creation
output "Domain_droplet" {
    value = "${digitalocean_domain.domain.id}"
}
output "Domain_load_balancer" {
    value = "${digitalocean_domain.domain_lb.id}"
}
output "Domain_floating_ip" {
    value = "${digitalocean_domain.domain_fip.id}"
}
output "Droplet_name" {
    value = "${digitalocean_droplet.web.name}"
}
output "Droplet_IP" {
    value = "${digitalocean_droplet.web.ipv4_address}"
}
output "Region" {
    value = "${digitalocean_droplet.web.region}"
}
output "Status" {
    value = "${digitalocean_droplet.web.status}"
}
output "Size" {
    value = "${digitalocean_droplet.web.size}"
}
output "Price_monthly" {
    value = "${digitalocean_droplet.web.price_monthly}"
}
output "Floating_IP_address" {
    value = "${digitalocean_floating_ip.web_fip.ip_address}"
}
output "Load_balancer_IP" {
  value = "${digitalocean_loadbalancer.web_lb.ip}"
}
output "Droplet_addresses" {
  value = "${join(",", digitalocean_droplet.web.*.ipv4_address)}"
}