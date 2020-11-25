terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.region
}

module "vpc" {
  source             = "app.terraform.io/rgomez-lab/vpc/aws"
  version            = "0.0.3"
  #source             = "../modules/terraform-aws-vpc"
  vpc_name           = "rgomez-test-vpc"
  availability_zones = ["${var.region}a", "${var.region}b"]
  vpc_cidr           = "192.168.0.0/16"
  public_subnets     = ["192.168.5.0/24", "192.168.6.0/24"]
  private_subnets    = ["192.168.7.0/24", "192.168.8.0/24"]
  vpc_dns_hostnames  = true
  vpc_dns_support    = true
  nat_gw             = false
}

module "security-group" {
  #source  = "app.terraform.io/rgomez-lab/security-group/aws"
  #version = "0.0.1"
  source   = "../modules/terraform-aws-security-group"
  vpc_id   = module.vpc.vpc_id
  vpc_name = module.vpc.vpc_name
  sg_name  = "sg-web"
  sg_rules = [{
    description = "SSH"
    port        = "22"
    protocol    = "tcp"
    cidr        = "0.0.0.0/0"
    sg_source   = ""
    },
    {
      description = "HTTP"
      port        = "80"
      protocol    = "tcp"
      cidr        = "0.0.0.0/0"
      sg_source   = ""
    },
    {
      description = "HTTPS"
      port        = "443"
      protocol    = "tcp"
      cidr        = "0.0.0.0/0"
      sg_source   = ""
  }]
}