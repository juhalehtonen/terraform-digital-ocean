# Basic Terraform with DigitalOcean
This basic Terraform setup allows easy creation of simple DigitalOcean servers, and optionally sets up domains for the created server.

## Known issues
- DigitalOcean does not currently support assigning Floating IPs to Load Balancers. As such, you cannot use both Load Balancers AND Floating IPs in a sane way yet.
- Droplet monitoring will land in the next TF update, and is not yet added here.
- Creating a record fails with 404 error, but subsequent apply works fine

## How to use
1. Install Terraform (On OSX you can even just do `brew install terraform`)
2. The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is `terraform init`, which initializes various local settings and data that will be used by subsequent commands.
3. Create a personal DO API key with read/write access (https://cloud.digitalocean.com/settings/api/tokens)
4. rename `secrets.tfvars.sample` to `secrets.tfvars` and add your DigitalOcean API token (*remember to .gitignore*): `digitalocean_token=your_do_token`
5. Fill in the variables located at `digital_ocean_create_droplet.tf`
5. Validate the configuration with `terraform validate`. No output is good news.
8. Run `terraform plan` to see what will happen.
9. Run `terraform apply` to apply the plan and create resources.
10. You now have a running server in DigitalOcean.
11. To update things, change things and things will change after re-applying

## Destroy changes
1. Run `terraform plan --destroy` to see what will happen when you initiate destroy.
2. Run `terraform destroy` and type `yes` to destroy the specified resources.
