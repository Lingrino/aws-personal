#################################
### Providers                 ###
#################################
provider "tls" {}

provider "aws" {
  region              = "us-east-1"
  allowed_account_ids = [var.account_id_prod]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_prod}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

provider "aws" {
  alias = "cert"

  region              = "us-east-1"
  allowed_account_ids = [var.account_id_prod]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_prod}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

provider "aws" {
  alias = "dns"

  region              = "us-east-1"
  allowed_account_ids = [var.account_id_prod]

  assume_role {
    role_arn     = "arn:aws:iam::${var.account_id_prod}:role/${var.assume_role_name}"
    session_name = var.assume_role_session_name
  }

  default_tags {
    tags = {
      terraform = "true"
    }
  }
}

#################################
### Terraform                 ###
#################################
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lingrino"

    workspaces {
      name = "aws-accounts-prod"
    }
  }

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    tls = {
      source = "hashicorp/tls"
    }
  }
}

#################################
### Remote State              ###
#################################
data "terraform_remote_state" "organization" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-common-organization"
    }
  }
}

data "terraform_remote_state" "account_audit" {
  backend = "remote"

  config = {
    organization = "lingrino"

    workspaces = {
      name = "aws-accounts-audit"
    }
  }
}
