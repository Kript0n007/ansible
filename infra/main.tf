terraform {
  required_version = ">= 1.8.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "iac_key" {
  key_name   = "iac_key"
  public_key = var.public_key

  lifecycle {
    prevent_destroy = true
    ignore_changes  = [public_key]
  }
}

resource "aws_security_group" "iac_sg" {
  name        = "iac_sg"
  description = "Abrir SSH e porta da aplicacao"

  lifecycle {
    prevent_destroy = true  # Evita que o SG seja destruído sem querer
    ignore_changes  = [description]  # Evita erro caso descrição mude
  }

  ingress {
    description = "Liberar SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Liberar HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Liberar HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Permitir todo trafego de saida"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app" {
  ami                    = var.ubuntu_ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.iac_key.key_name
  vpc_security_group_ids = [aws_security_group.iac_sg.id]

  tags = {
    Name = "iac-app"
  }
}
