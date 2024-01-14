# main.tf

terraform {
  required_version = "~> 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # Change this to your desired AWS region
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0c7217cdde317cfec" # Amazon Linux 2 AMI, adjust as needed
  instance_type          = "t2.micro"              # Adjust the instance type as needed
  key_name               = "ansible-key"
  vpc_security_group_ids = ["sg-0d04cb9e5e9498eae"]
  subnet_id              = "subnet-039837a934caf965c"

  root_block_device {
    volume_size = "10"
  }

  tags = {
    Name = "nginx_server"
  }

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    amazon-linux-extras install nginx1.12 -y
    systemctl start nginx
    systemctl enable nginx
    echo "we're the best" > /usr/share/nginx/html/index.html
  EOF
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}
