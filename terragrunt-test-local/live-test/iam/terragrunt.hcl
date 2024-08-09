include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/service_account"
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  #common
  project = local.common_vars.project_id
  region  = local.common_vars.region
  #service account
  account_id = "terragrunt-test-sa"

}
