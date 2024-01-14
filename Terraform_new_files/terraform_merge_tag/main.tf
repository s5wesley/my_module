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

variable "tags" {
  type = map(any)
  default = {
    "id"             = "1668"
    "owner"          = "S5WESLEY"
    "teams"          = "THE WARRIORS"
    "environment"    = "development"
    "project"        = "devOps"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
  }
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
  tags = merge(var.tags, {
    Name = format("%s-bastion-host", var.tags["environment"])
    },
  )
}