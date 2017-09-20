# Droplet variables
# Docs: https://www.terraform.io/docs/providers/do/r/droplet.html
droplet_name = "terraform-sample"
droplet_image = "ubuntu-16-04-x64"
droplet_region = "ams3"
droplet_size = "512mb"
droplet_count = 1
droplet_backups = false

# Domain vars, No domain work is done if `create_domain` is `false`
create_domain = false
domain_name = "yourdomain.io"

# NOTE: You cannot assign floating IPs to load balancers currently, no reason to create both now
# Load Balancer vars, no load balancer is created if `create_load_balancer` is `false`
create_load_balancer = false
# Floating IP vars, no floating IP is created if `create_floating_ip` is `false`
create_floating_ip = false