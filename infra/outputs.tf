output "instance_public_ip" {
  description = "IP público da instância EC2"
  value       = aws_instance.app.public_ip
}

output "ansible_connection" {
  description = "Comando de conexão via SSH"
  value       = "ubuntu@${aws_instance.app.public_ip}"
}
