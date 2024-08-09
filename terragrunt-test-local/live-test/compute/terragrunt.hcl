include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/compute"
}

dependency "vpc" {
  config_path = "../network"

}

dependency "sa" {
  config_path = "../iam"

  mock_outputs_allowed_terraform_commands = ["validate", "plan", "apply", "destroy"]
  mock_outputs = {
    sa_email = "terragrunt-test-sa@casetext-dr.iam.gserviceaccount.com"
  }
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  #common
  project = local.common_vars.project_id
  region  = local.common_vars.region
  #compute
  vm_name  = "terragrunt-test-vm"
  vpc_name = dependency.vpc.outputs.vpc_name
  sa_email = dependency.sa.outputs.sa_email

}
