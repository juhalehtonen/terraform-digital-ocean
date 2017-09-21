/**
 * Configuration for the Terraform setup.
 *
 * This file exposes the variables available in main.tf. You should not need to touch
 * this, as the actual value definitions should be done in `terraform.tfvars`.
 */

# API
variable "digitalocean_token" {
  description = "Your DigitalOcean API token with read/write permissions."
  default = "YOUR_API_TOKEN"
}

# Domain
variable "create_domain" {
  description = "Boolean whether or not to create a domain"
  default = false
}
variable "domain_name" {
  description = "Domain to configure, if desired."
  default = "domain.com"
}

# Droplets
variable "droplet_name" {
  description = "Name of the Droplet(s). Will be post-fixed with index number"
  default = "terraform-sample"
}
variable "droplet_count" {
  description = "Number of Droplets to provision."
  default = 1
}
variable "droplet_image" {
  description = "Base image to use to provision Droplets."
  default = "ubuntu-16-04-x64"
}
variable "droplet_region" {
  description = "DigitalOcean region in which to create resources."
  default = "ams3"
}
variable "droplet_size" {
  description = "Amount of available RAM for the Droplet"
  default = "512mb"
}
variable "droplet_backups" {
  description = "Enable or disable automated backups"
  default = false
}

# Load balancer
variable "create_load_balancer" {
  description = "Boolean whether or not to create a load balancer"
  default = false
}
variable "load_balancer_protocol" {
  description = "Choose a load balancer protocol"
  default = "http"
}

# Floating IP
variable "create_floating_ip" {
  description = "Boolean whether or not to create a floating IP"
  default = false
}

# Scripts
variable "scripts_to_run" {
    type = "list"
    description = "List of bash scripts to run after servers are provisioned"
    default = ["scripts/update.sh", "scripts/users.sh", "scripts/nginx.sh", "scripts/ufw.sh", "scripts/ssh.sh"]
}
