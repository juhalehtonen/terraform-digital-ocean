# Define variables to be used
variable "digitalocean_token" {} // Comes from secrets.tfvars
variable "domain_name" {} // Comes from secrets.tfvars
variable "droplet_name" {} // Comes from terraform.tfvars
variable "droplet_region" {} // Comes from terraform.tfvars
variable "droplet_size" {} // Comes from terraform.tfvars
variable "droplet_backups" {} // Comes from terraform.tfvars
variable "create_domain" {
  description = "If set to true, create a domain and a CNAME record for this resource"
}


# Define provider
provider "digitalocean" {
  token = "${var.digitalocean_token}"
}


# Define resource details
# The web word is arbitrary, it serves the purpose of an identifier in this
# declaration, as such, you can choose whatever name you’re most comfortable with.
resource "digitalocean_droplet" "web" {
  image  = "ubuntu-16-04-x64"
  name   = "${var.droplet_name}"
  region = "${var.droplet_region}"
  size   = "${var.droplet_size}"
  backups = "${var.droplet_backups}"
}


# Create a new domain
# NOTE: This & the record are not created if `create_domain` is `false`
resource "digitalocean_domain" "web" {
    count = "${var.create_domain}"
    name = "${var.domain_name}"
    ip_address = "${digitalocean_droplet.web.ipv4_address}"
}

# Add a CNAME record to the domain
# NOTE: This & the domain are not created if `create_domain` is `false`
resource "digitalocean_record" "web" {
    count = "${var.create_domain}"
    domain = "${digitalocean_domain.web.name}"
    type = "CNAME"
    value =  "${digitalocean_domain.web.name}."
    name = "www"
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
