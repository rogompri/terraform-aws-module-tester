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
  public_subnets     = ["192.168.5.0/24", "192.168.6.0/24"]
  private_subnets    = ["192.168.7.0/24", "192.168.8.0/24"]
  vpc_dns_hostnames  = true
  vpc_dns_support    = true
  nat_gw             = true
}