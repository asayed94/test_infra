locals {
  my_babbel_fqdn = "my.${data.terraform_remote_state.babbel["domains"].outputs.brand_domain}"
}
