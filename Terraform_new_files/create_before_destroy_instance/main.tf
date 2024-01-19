terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = "ansible-key"
  vpc_security_group_ids = ["sg-0d04cb9e5e9498eae"]
  subnet_id              = "subnet-039837a934caf965c"
  root_block_device {
    volume_size = "10"
  }
  tags = {
    "Name"           = "wesley_Dev2"
    "id"             = "2560"
    "owner"          = "Wesley LLC"
    "teams"          = "DEV"
    "environment"    = "dev"
    "project"        = "team A"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }

  lifecycle {
    create_before_destroy = true
  }
}