resource "github_repository" "infra-personal" {
  name         = "infra-personal"
  description  = "Terraform for setting up my personal infrastructure"
  homepage_url = "https://lingrino.com"

  default_branch = "master"
  private        = false

  has_wiki   = false
  has_issues = true

  allow_merge_commit = true
  allow_squash_merge = true
  allow_rebase_merge = true

  topics = [
    "automation",
    "aws",
    "cloud",
    "infrastructure",
    "terraform",
  ]
}

resource "github_branch_protection" "infra-personal" {
  repository     = github_repository.infra-personal.name
  branch         = "master"
  enforce_admins = true

  required_status_checks {
    strict   = true
    contexts = ["validate"]
  }
}
