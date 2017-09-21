# Terraform with DigitalOcean
A simple Terraform configuration setup to create a configurable number of DigitalOcean droplets, load balancers, floating IPs, domains & domain records, with basic scripts to set up a typical web machine with nginx.

*Note*: This is a personal Terraform playground and a learning experience, definitely not safe for production use.

## How to use
1. Install Terraform (On OSX you can just do `brew install terraform` if you trust Homebrew)
2. The first command to run for a new configuration -- or after checking out an existing configuration from version control -- is `terraform init`, which initializes various local settings and data that will be used by subsequent commands.
3. Create a personal DigitalOcean API key with read/write access (https://cloud.digitalocean.com/settings/api/tokens).
4. Rename `secrets.tfvars.sample` to `secrets.tfvars` and add your DigitalOcean API token. Remember to .gitignore the file (ignored by this repo by default): `digitalocean_token=your_do_token`
5. Fill in the variables located at `terraform.tfvars` depending on what kind of setup you want.
6. Add in your SSH key ID(s) to initiate the droplets with key-based authentication. You can get the list of IDs with `curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer YOUR_DO_API_TOKEN" "https://api.digitalocean.com/v2/account/keys"`
7. Validate the configuration with `terraform validate`. No output is good news.
8. Run `terraform plan` to see what will happen.
9. Run `terraform apply` to apply the plan and create resources.
10. Wait. A single server gets spun up in around 30 secs (plus Bash script execution time), but a multi-droplet load-balanced setup with domains and domain records can take a few minutes to be finished.

## Bash scripts
This repo contains a set of simple Bash scripts, located in the `scripts/` directory. These script files are configured to be run on the Droplets once created. You can find the ordered list of scripts to be run at `terraform.tfvars`.

## Destroy changes
1. Run `terraform plan --destroy` to see what will happen when you initiate destroy.
2. Run `terraform destroy` and type `yes` to destroy the specified resources.

## Known issues
- Creating a record sometimes fails with 404 error, but subsequent apply works fine.
- DigitalOcean does not currently support assigning Floating IPs to Load Balancers. As such, you cannot use both Load Balancers AND Floating IPs in a sane way yet. You should choose one or the other.
- Droplet monitoring will land in the next TF update, and is not yet added here.
