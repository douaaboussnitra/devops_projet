terraform {
  required_providers {
    aws = { source = "hashicorp/aws", version = "~> 5.0" }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Security Group pour k3s
resource "aws_security_group" "k3s_sg" {
  name = "k3s-sg"

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# VM Master
resource "aws_instance" "master" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]
  tags = {
    Name = "k3s-master"
  }
}

# VM Worker
resource "aws_instance" "worker" {
  ami                    = "ami-0c02fb55956c7d316"
  instance_type          = "t3.micro"
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.k3s_sg.id]
  tags = {
    Name = "k3s-worker"
  }
}

# Outputs pour récupérer les IPs publiques
output "master_ip" {
  value = aws_instance.master.public_ip
}

output "worker_ip" {
  value = aws_instance.worker.public_ip
}
