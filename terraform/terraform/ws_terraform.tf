resource "tfe_workspace" "terraform" {
  organization = tfe_organization.org.id
  name         = "terraform"

  terraform_version = "latest"
  working_directory = "terraform/terraform"

  operations            = true # TODO
  auto_apply            = true
  queue_all_runs        = false
  file_triggers_enabled = true

  vcs_repo {
    identifier     = "lingrino/infra-personal"
    oauth_token_id = var.oauth_token_id
  }
}
