# ShipTrack operations runbook

## App returns 5xx or does not respond

1. Check target health in the EC2 Load Balancer target group.
2. Inspect service events:

   ```bash
   aws ecs describe-services --cluster shiptrack-cluster --services shiptrack-service
   ```

3. Read application logs:

   ```bash
   aws logs tail /ecs/shiptrack --follow
   ```

4. Confirm the container listens on port `3000` and `GET /health` returns HTTP 200.

## GitHub deployment fails

1. Confirm `AWS_DEPLOY_ROLE_ARN` is a GitHub repository secret.
2. Confirm `github_repository` in Terraform exactly matches `owner/repository`.
3. Confirm the role trust policy permits pushes to `main`.
4. Confirm `infra/task-definition.json` contains the task execution-role ARN produced by Terraform.

## Teardown

Run this after demos to avoid ongoing AWS charges:

```bash
terraform -chdir=infra destroy
```
