resource "google_service_account" "terragrunt-test-sa" {
  account_id   =  var.account_id
  display_name = "Custom SA for VM Instance"
}
