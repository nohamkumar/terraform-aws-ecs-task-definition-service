resource "aws_ecs_service" "service" {
  launch_type = "FARGATE"

  name            = var.ecs_service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.td.arn
  desired_count   = var.ecs_service_td_desired_count

  load_balancer {
    target_group_arn = var.lb_target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = var.subnets
    assign_public_ip = true
    security_groups  = [aws_security_group.task_sg.id]
  }

  lifecycle {
    ignore_changes = [desired_count]
  }

  depends_on = [
    aws_security_group_rule.egress,
    aws_security_group_rule.ingress,
    aws_security_group.task_sg,
    aws_ecs_task_definition.td,
    aws_iam_role.task_execution_role,
    aws_iam_role.task_role,
  ]

  tags = module.this.tags
}
