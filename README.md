# ShipTrack DevOps Project

ShipTrack is a beginner-friendly shipment tracking API deployed as a Docker container on AWS ECS Fargate. It demonstrates a placement-ready DevOps delivery path: testing, Docker, GitHub Actions, Terraform, AWS IAM/OIDC, ECR, ECS, load balancing, logs, and alerts.

## Architecture

See [the architecture guide](docs/architecture.md). The delivery path is:

```text
GitHub -> GitHub Actions -> Amazon ECR -> Amazon ECS Fargate -> ALB -> API
                                      \-> CloudWatch Logs and CPU alarm
```

## Prerequisites

- Node.js 20+
- Docker Desktop
- Git
- AWS CLI configured with an AWS account
- Terraform 1.5+
- A GitHub repository

## Run locally

```bash
npm install
npm test
npm start
curl http://localhost:3000/health
```

In another terminal, create a shipment:

```bash
curl -X POST http://localhost:3000/shipments \
  -H 'Content-Type: application/json' \
  -d '{"trackingNumber":"ST-3001","destination":"Delhi"}'
```

## Run with Docker

```bash
docker build -t shiptrack:local .
docker run --rm -p 3000:3000 shiptrack:local
curl http://localhost:3000/health
```

Or use:

```bash
docker compose up --build
```

## Deploy infrastructure

1. Create a new empty GitHub repository named `shiptrack-devops` and push this project to it.
2. Copy the Terraform variable template and set your real GitHub repository:

   ```bash
   cp infra/terraform.tfvars.example infra/terraform.tfvars
   ```

3. Provision infrastructure:

   ```bash
   terraform -chdir=infra init
   terraform -chdir=infra fmt -recursive
   terraform -chdir=infra validate
   terraform -chdir=infra plan
   terraform -chdir=infra apply
   ```

4. Retrieve the outputs:

   ```bash
   terraform -chdir=infra output
   ```

5. Copy `github_deploy_role_arn` into GitHub repository **Settings → Secrets and variables → Actions** as the secret `AWS_DEPLOY_ROLE_ARN`.
6. Replace `REPLACE_WITH_TERRAFORM_OUTPUT_TASK_EXECUTION_ROLE_ARN` in `infra/task-definition.json` with `task_execution_role_arn` from Terraform output. Commit and push this update.
7. Push to `main`. The deployment workflow builds, tags, pushes, and deploys the image automatically.
8. Open `application_url` from Terraform output and visit `/health`.

## Common commands

```bash
make test
make lint
make docker-build
make tf-plan
aws logs tail /ecs/shiptrack --follow
terraform -chdir=infra destroy
```

## Cost warning

AWS resources can incur charges, especially an Application Load Balancer. Keep `desired_count = 1` during learning and remove resources when not demonstrating the project:

```bash
terraform -chdir=infra destroy
```

## Project milestones

1. Local API and tests
2. Dockerized application
3. CI workflow passing on GitHub
4. Terraform creates AWS resources
5. ECS deployment through GitHub Actions
6. CloudWatch logs, alarm, screenshots, and a short demo video

## Interview talking points

- Chose ECS Fargate to learn container orchestration and AWS networking without operating EC2 instances or a Kubernetes control plane.
- Used Terraform to make cloud infrastructure reproducible and reviewable.
- Used OIDC so GitHub Actions receives short-lived AWS credentials rather than storing static access keys.
- Restricted API task ingress to the ALB security group and exposed only HTTP from the load balancer.

See [the runbook](docs/runbook.md) for troubleshooting and cleanup.
