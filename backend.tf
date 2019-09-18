terraform {
  required_version = "~>0.12"

  backend "s3" {
    bucket                  = "tfm-remote-state-240442524813"
    region                  = "eu-west-1"
    key                     = "dyn-db.tfstate"
    encrypt                 = "true"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "ofs-sandbox"
  }
}

################
# Connecting to Other Remote States - activate as needed
################


/*
data "terraform_remote_state" "mgmt_base" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_s3_auto}"
    region = "eu-west-1"
    key    = "env:/${var.mgmt_wkspc}/mgmt-base.tfstate"
  }
}

data "terraform_remote_state" "mgmt_ec2" {
  backend = "s3"

  config {
    bucket = "${var.remote_state_s3_auto}"
    region = "eu-west-1"
    key    = "env:/${var.mgmt_wkspc}/mgmt-ec2.tfstate"
  }
}
*/

