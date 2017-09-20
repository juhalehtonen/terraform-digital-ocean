# Define variables to be used
variable "digitalocean_token" {}
variable "domain_name" {}

variable "droplet_name" {}
variable "droplet_count" {}
variable "droplet_image" {}
variable "droplet_region" {}
variable "droplet_size" {}
variable "droplet_backups" {}

variable "load_balancer_protocol" {}

variable "create_domain" {}
variable "create_floating_ip" {}
variable "create_load_balancer" {}

variable "scripts_to_run" {
    type = "list"
}