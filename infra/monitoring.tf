resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "${local.name}-high-cpu"
  alarm_description   = "ECS service CPU is above 80 percent"
  namespace           = "AWS/ECS"
  metric_name         = "CPUUtilization"
  statistic           = "Average"
  period              = 300
  evaluation_periods  = 2
  threshold           = 80
  comparison_operator = "GreaterThanThreshold"

  dimensions = {
    ClusterName = aws_ecs_cluster.app.name
    ServiceName = aws_ecs_service.app.name
  }
}
