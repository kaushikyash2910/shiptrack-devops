# ShipTrack architecture

```text
GitHub push
    |
    +--> CI: lint, test, Docker build
    |
    +--> CD: GitHub OIDC -> AWS IAM role -> ECR -> ECS deployment
                                                    |
Internet -> Application Load Balancer -> ECS Fargate service -> CloudWatch Logs
```

The load balancer accepts HTTP on port 80 and forwards it to port 3000 on the API tasks. The ECS task security group only accepts traffic from the load balancer security group.

## Learning-cost design

This starter puts the ALB and Fargate tasks in public subnets and assigns public IPs to tasks. The security group still prevents direct application access. It avoids a NAT Gateway charge while learning. A production upgrade would place tasks in private subnets and add a NAT Gateway or VPC endpoints for ECR and CloudWatch.
