variable "aws_region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "ubuntu_ami_id" {
  description = "AMI do Ubuntu 22.04"
  type        = string
}

variable "instance_type" {
  description = "Tipo da instância EC2"
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Caminho da chave pública SSH"
  type        = string
}

variable "public_key" {
  description = "Chave pública SSH para EC2"
  type        = string
}


