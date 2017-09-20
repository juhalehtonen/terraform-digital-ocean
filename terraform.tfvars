# Droplet variables, required
droplet_name = "terraform-sample"
droplet_region = "ams3"
droplet_size = "512mb"
droplet_backups = false
# Domain variables, No domain work is done if `create_domain` is `false`
create_domain = false
domain_name = "yourdomain.io"
# Floating IP variables, No floating IP is created if `create_floating_ip` is `false`
create_floating_ip = false
