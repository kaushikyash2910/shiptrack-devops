output "application_url" {
  description = "Public URL of the ShipTrack API."
  value       = "http://${aws_lb.app.dns_name}"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "github_deploy_role_arn" {
  description = "Add this value as the AWS_DEPLOY_ROLE_ARN GitHub Actions secret."
  value       = aws_iam_role.github_deploy.arn
}

output "task_execution_role_arn" {
  description = "Place this value in infra/task-definition.json before enabling the deployment workflow."
  value       = aws_iam_role.task_execution.arn
}
