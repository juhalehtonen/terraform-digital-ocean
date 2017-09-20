# Define variables to be used
variable "digitalocean_token" {}
variable "domain_name" {}

variable "droplet_name" {}
variable "droplet_count" {}
variable "droplet_image" {}
variable "droplet_region" {}
variable "droplet_size" {}
variable "droplet_backups" {}

variable "create_domain" {}
variable "create_floating_ip" {}
variable "create_load_balancer" {}


# Define provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}


# Define Droplet
# The web word is arbitrary, it serves the purpose of an identifier in this
# declaration, as such, you can choose whatever name you’re most comfortable with.
resource "digitalocean_droplet" "web" {
    count   = "${var.droplet_count}"
    image   = "${var.droplet_image}"
    name    = "${var.droplet_name}-${count.index}"
    region  = "${var.droplet_region}"
    size    = "${var.droplet_size}"
    backups = "${var.droplet_backups}"
    ipv6    = "${var.create_floating_ip}" #Required for floating IP
    private_networking = "${var.create_floating_ip}" #Required for floating IP
}

# Define load balancer
resource "digitalocean_loadbalancer" "web" {
    count  = "${var.create_load_balancer}"
    name   = "${var.droplet_name}-lb"
    region = "${var.droplet_region}"

    forwarding_rule {
        entry_port     = 80
        entry_protocol = "http"

        target_port     = 80
        target_protocol = "http"
    }

    algorithm   = "round_robin"
    droplet_ids = ["${digitalocean_droplet.web.*.id}"]
}


# Define Floating IP
# NOTE: This is not created if `create_floating_ip` is `false`
resource "digitalocean_floating_ip" "web" {
    count      = "${var.create_floating_ip}"
    droplet_id = "${digitalocean_droplet.web.id}"
    region     = "${digitalocean_droplet.web.region}"
}


# Create a new domain
# NOTE: This & the record are not created if `create_domain` is `false`
resource "digitalocean_domain" "web" {
    count      = "${var.create_domain}"
    name       = "${var.domain_name}"
    ip_address = "${digitalocean_droplet.web.ipv4_address}"
}

# Add a CNAME record to the domain
# NOTE: This & the domain are not created if `create_domain` is `false`
resource "digitalocean_record" "web" {
    count  = "${var.create_domain}"
    domain = "${digitalocean_domain.web.name}"
    type   = "CNAME"
    value  =  "${digitalocean_domain.web.name}."
    name   = "www"
}


# Define output variables to be displayed after creation
output "Domain" {
    value = "${digitalocean_domain.web.id}"
}
output "Droplet_name" {
    value = "${digitalocean_droplet.web.name}"
}
output "IP" {
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
    value = "${digitalocean_floating_ip.web.ip_address}"
}
