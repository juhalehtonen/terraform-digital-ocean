# Define provider
provider "digitalocean" {
    token = "${var.digitalocean_token}"
}


# Define Droplet
# The web word is arbitrary, it serves the purpose of an identifier in this
# declaration, as such, you can choose whatever name you’re most comfortable with.
resource "digitalocean_droplet" "web" {
    count    = "${var.droplet_count}"
    image    = "${var.droplet_image}"
    name     = "${var.droplet_name}-${count.index}"
    region   = "${var.droplet_region}"
    size     = "${var.droplet_size}"
    backups  = "${var.droplet_backups}"
    ipv6     = "${var.create_floating_ip}" #Required for floating IP
    private_networking = "${var.create_floating_ip}" #Required for floating IP
    ssh_keys = [13209286] # Get with curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer your_do_api_token" "https://api.digitalocean.com/v2/account/keys"

    provisioner "remote-exec" {
        scripts = "${var.scripts_to_run}"

        connection {
            type     = "ssh"
            private_key = "${file("~/.ssh/id_juhukka")}"
            user     = "root"
            timeout  = "2m"
        }
    }

}


# Define load balancer
resource "digitalocean_loadbalancer" "web_lb" {
    count  = "${var.create_load_balancer}"
    name   = "${var.droplet_name}-lb"
    region = "${var.droplet_region}"

    forwarding_rule {
        entry_port     = 80
        entry_protocol = "${var.load_balancer_protocol}"

        target_port     = 80
        target_protocol = "${var.load_balancer_protocol}"
    }

    healthcheck {
        port = 80
        protocol = "${var.load_balancer_protocol}"
        path = "/"
        check_interval_seconds = 10
    }

    algorithm   = "round_robin"
    droplet_ids = ["${digitalocean_droplet.web.*.id}"]
}


# Define Floating IP
# NOTE: This is not created if `create_floating_ip` is `false`
resource "digitalocean_floating_ip" "web_fip" {
    count      = "${var.create_floating_ip}"
    droplet_id = "${digitalocean_droplet.web.0.id}"
    region     = "${digitalocean_droplet.web.0.region}"
}


# Create a new domain
# Create IF floating IP is created
resource "digitalocean_domain" "domain_fip" {
    count      = "${var.create_domain == 1 && var.create_floating_ip == 1 ? 1 : 0}"
    name       = "${var.domain_name}"
    ip_address = "${digitalocean_floating_ip.web_fip.ip_address}"
}
# Create IF load balancer is created BUT NOT load balancer
resource "digitalocean_domain" "domain_lb" {
    count      = "${var.create_domain == 1 && var.create_load_balancer == 1 && var.create_floating_ip == 0 ? 1 : 0}"
    name       = "${var.domain_name}"
    ip_address = "${digitalocean_loadbalancer.web_lb.ip}"
}
# Create IF neither load balancer NOR floating IP is created
resource "digitalocean_domain" "domain" {
    count      = "${var.create_domain == 1 && var.create_load_balancer == 0 && var.create_floating_ip == 0 ? 1 : 0}"
    name       = "${var.domain_name}"
    ip_address = "${digitalocean_droplet.web.0.ipv4_address}"
}

# Add a CNAME record to the domain
# NOTE: This & the domain are not created if `create_domain` is `false`
resource "digitalocean_record" "record" {
    count  = "${var.create_record}"
    domain = "${var.domain_name}"
    type   = "CNAME"
    value  =  "${var.domain_name}."
    name   = "www"
}
