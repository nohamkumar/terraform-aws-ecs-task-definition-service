
#------
#TASK IAM
#------

resource "aws_iam_policy" "task_policy" {
  name   = "${module.this.id}-ecs-task-policy"
  policy = data.aws_iam_policy_document.task_policy.json

  tags = merge(
    module.this.tags,
    {
      Name = "${module.this.id}-ecs-task-policy"
    }
  )
}

resource "aws_iam_role" "task_role" {
  name               = "${module.this.id}-ecsTaskRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json

  tags = merge(
    module.this.tags,
    {
      Name = "${module.this.id}-ecsTaskRole"
    }
  )
}

resource "aws_iam_policy_attachment" "task_policy_attachment" {
  name       = "${module.this.id}-ecs-task-policy-attachment"
  roles      = [aws_iam_role.task_role.name]
  policy_arn = aws_iam_policy.task_policy.arn
}


#------
#TAST EXECUTION IAM
#------

resource "aws_iam_role" "task_execution_role" {
  name               = "${module.this.id}-ecsTaskExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_assume.json

  tags = merge(
    module.this.tags,
    {
      Name = "${module.this.id}-ecsTaskExecutionRole"
    }
  )
}

resource "aws_iam_policy_attachment" "task_execution_policy_attachment" {
  name       = "${module.this.id}-ecs-task-execution-policy-attachment"
  roles      = [aws_iam_role.task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

