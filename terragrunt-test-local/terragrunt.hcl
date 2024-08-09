generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "google" {
  project = "casetext-dr"
  region  = "us-west1"
}
EOF
}

remote_state {
  backend = "gcs"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "ct-tfstate-test-picco"
    prefix = "envs/casetext-dr/${path_relative_to_include()}"
  }
}
