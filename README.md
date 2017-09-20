# Basic Terraform with DigitalOcean
Note: This is a personal Terraform playground and a learning experience, definitely not safe for production use.

## How to use
1. Install Terraform (On OSX you can just do `brew install terraform` if you trust Homebrew)
2. The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is `terraform init`, which initializes various local settings and data that will be used by subsequent commands.
3. Create a personal DigitalOcean API key with read/write access (https://cloud.digitalocean.com/settings/api/tokens).
4. Rename `secrets.tfvars.sample` to `secrets.tfvars` and add your DigitalOcean API token. Remember to .gitignore the file (ignored by this repo by default): `digitalocean_token=your_do_token`
5. Fill in the variables located at `digital_ocean_create_droplet.tf` depending on what kind of setup you want.
5. Validate the configuration with `terraform validate`. No output is good news.
8. Run `terraform plan` to see what will happen.
9. Run `terraform apply` to apply the plan and create resources.
10. Wait. A single server gets spun up in 30 secs, but a multi-droplet load-balanced setup with domain names and records can take a few minutes to be finished.

## Destroy changes
1. Run `terraform plan --destroy` to see what will happen when you initiate destroy.
2. Run `terraform destroy` and type `yes` to destroy the specified resources.

## Known issues
- Creating a record fails with 404 error, but subsequent apply works fine.
- DigitalOcean does not currently support assigning Floating IPs to Load Balancers. As such, you cannot use both Load Balancers AND Floating IPs in a sane way yet. You should choose one or the other.
- Droplet monitoring will land in the next TF update, and is not yet added here.