terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-west-3"
}

module "vpc" {
  source             = "app.terraform.io/rgomez-lab/vpc/aws"
  version            = "0.0.1"
  vpc_name           = "rgomez-test-vpc"
  availability_zones = ["eu-west-3a", "eu-west-3b"]
  vpc_cidr           = "192.168.0.0/16"
  public_subnets     = ["192.168.1.0/32", "192.168.2.0/32"]
  private_subnets    = ["192.168.3.0/32", "192.168.4.0/32"]
  vpc_dns_hostnames  = true
  vpc_dns_support    = true
  nat_gw             = true
}