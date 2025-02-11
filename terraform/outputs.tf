output "gitlab_public_ip" {
  value = aws_instance.gitlab-server.public_ip
}

output "gitlab_public_dns" {
  value = aws_instance.gitlab-server.public_dns
}

output "gitlab_runner_public_ip" {
  value = aws_instance.gitlab-runner.public_ip
}

output "gitlab_runner_public_dns" {
  value = aws_instance.gitlab-runner.public_dns
}

output "deployment_server_public_ip" {
  value = aws_instance.deployment-server.public_ip
}

output "deployment_server_public_dns" {
  value = aws_instance.deployment-server.public_dns
}