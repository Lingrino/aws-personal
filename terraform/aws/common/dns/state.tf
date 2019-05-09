terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "aws-common-dns"
    }
  }
}

data "terraform_remote_state" "account_audit" {
  backend = "remote"

  config {
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-audit"
    }
  }
}
