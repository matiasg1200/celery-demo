Terragrunt playground

This repo should work as small playground to get familiar with terragrunt if you have little or no previous experience with it. 
The structure of the repo and of the terragrunt workflow kind off "mimics" the same layout that we have at the devesecops repo at envs/

Overview

The repo conists of the following layout:

```console
.
├── README.md
├── common_vars.yaml
├── live-test
│   ├── compute
│   │   └── terragrunt.hcl
│   ├── iam
│   │   └── terragrunt.hcl
│   └── network
│       └── terragrunt.hcl
├── modules
│   ├── compute
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── service_account
│   │   ├── main.tf
│   │   └── variables.tf
│   └── vpc
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── provider.tf
```

under `modules/` there are small samples that will create the following resoruces:
- VPC with auto subnet creation enabled
- Service account
- Compute engine VM

under `live-tes/` you will find the terragrunt files that will deploy the resoruces leveraging the terraform `modules` described above

what you will learn

Hopefully this short demo will help you to get familiar with:
- gettig started with terragrunt 
- exploring terraform and dependecy blocks 
- understanding and utilizing outpus and mock outputs

Usage:

Lets start by analyzing the different code blocks from the `terragrunt.hcl` files.` 

```console
include "root" {
  path = find_in_parent_folders()
}
```
>snippet from `live-test\network\terragrunt.hcl`

the include block is used to specify is used to specify inheritance of Terragrunt configuration files. In this case its used to find configuration files at the root directory where we specify the provider and backend configurations
supporting docs:
- include: https://terragrunt.gruntwork.io/docs/reference/config-blocks-and-attributes/#include
- find_in_parent_folders(): https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#find_in_parent_folders

```console
terraform {
  source = "../../modules/vpc"
}
```
The terraform block is used to configure how terragrunt will interact with terraform. In this 

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  #common
  project = local.common_vars.project_id
  region  = local.common_vars.region
  #vpc
  vpc_name                = "terragrunt-test-vpc"
  auto_create_subnetworks = true

}


start by running `terragrunt plan -out $(pwd)/demo -no-color > plan_output` on `live-test\network`. This will create an output file that can be used later during an apply command (same as in Terraform).