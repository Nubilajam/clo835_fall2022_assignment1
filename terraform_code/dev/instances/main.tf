

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
<<<<<<< HEAD
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
=======
#data "aws_ami" "latest_amazon_linux" {
#  owners      = ["amazon"]
 # most_recent = true
  #filter {
  #  name   = "name"
   # values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  #}
#}
>>>>>>> 713f5ae098fe56de72e076951634f00ffc2b9c53


# Data source for availability zones in us-east-1
data "aws_availability_zones" "available" {
  state = "available"
}

# Data block to retrieve the default VPC id
<<<<<<< HEAD
data "aws_vpc" "default" {
  default = true
}
=======
#data "aws_vpc" "default" {
 # default = true
#}
>>>>>>> 713f5ae098fe56de72e076951634f00ffc2b9c53

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

<<<<<<< HEAD
# Reference subnet provisioned by 01-Networking 
resource "aws_instance" "my_amazon" {
  ami                         = data.aws_ami.latest_amazon_linux.id
  instance_type               = lookup(var.instance_type, var.env)
  key_name                    = aws_key_pair.my_key.key_name
  vpc_security_group_ids             = [aws_security_group.my_sg.id]
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-Amazon-Linux"
    }
  )
}


# Adding SSH key to Amazon EC2
resource "aws_key_pair" "my_key" {
  key_name   = local.name_prefix
  public_key = file("${local.name_prefix}.pub")
}

# Security Group
resource "aws_security_group" "my_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

 ingress {
    description      = "SSH from everywhere"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }
  ingress {
    description =" allow_http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-sg"
    }
  )
}


=======
>>>>>>> 713f5ae098fe56de72e076951634f00ffc2b9c53
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

<<<<<<< HEAD

# Elastic IP
resource "aws_eip" "static_eip" {
  instance = aws_instance.my_amazon.id
  tags = merge(local.default_tags,
    {
      "Name" = "${local.name_prefix}-eip"
    }
  )
}
=======
>>>>>>> 713f5ae098fe56de72e076951634f00ffc2b9c53