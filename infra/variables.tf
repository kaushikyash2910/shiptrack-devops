variable "aws_region" {
  description = "AWS region for all resources."
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "A short, lowercase project prefix."
  type        = string
  default     = "shiptrack"
}

variable "environment" {
  description = "Deployment environment name."
  type        = string
  default     = "dev"
}

variable "github_repository" {
  description = "GitHub repository allowed to deploy, for example yashkaushik/shiptrack-devops."
  type        = string
}

variable "desired_count" {
  description = "Number of API tasks. Keep 1 while learning to reduce cost."
  type        = number
  default     = 1
}
