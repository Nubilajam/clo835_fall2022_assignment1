

#----------------------------------------------------------
# ACS730 - Week 3 - Terraform Introduction
#
# Build EC2 Instances
#
#----------------------------------------------------------

#  Define the provider
provider "aws" {
  region = "us-east-1"
}

# Data source for AMI id
#data "aws_ami" "latest_amazon_linux" {
#  owners      = ["amazon"]
 # most_recent = true
  #filter {
  #  name   = "name"
   # values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  #}
#}


# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Data block to retrieve the default VPC id
#data "aws_vpc" "default" {
 # default = true
#}

# Define tags locally
locals {
  default_tags = merge(module.globalvars.default_tags, { "env" = var.env })
  prefix       = module.globalvars.prefix
  name_prefix  = "${local.prefix}-${var.env}"
}

# Retrieve global variables from the Terraform module
module "globalvars" {
  source = "../../modules/globalvars"
}

# ECR Repository
# Create AWS app repo
resource "aws_ecr_repository" "web_app" {
    name = "webapp_nubila_ecr"
    image_tag_mutability = "MUTABLE"
}

# Create AWS sql repo
resource "aws_ecr_repository" "sql_app" {
    name = "sql_nubila_ecr"
    image_tag_mutability = "MUTABLE"
}

