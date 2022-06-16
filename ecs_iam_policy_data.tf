data "aws_iam_policy_document" "ecs_task_assume" {
  version = "2012-10-17"
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"

      identifiers = [
        "ecs.amazonaws.com",
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

#-------
#FOR TASK
#-------

data "aws_iam_policy_document" "task_policy" {
  version = "2012-10-17"
  statement {
    effect = "Allow"
    actions = [
      "autoscaling:Describe*",
      "cloudwatch:*",
      "logs:*",
      "sns:*",
      "iam:GetPolicy",
      "iam:GetPolicyVersion",
      "iam:GetRole",
      "ssm:*"
    ]

    resources = [
      "*"
    ]

  }
}

#-------
#FOR TASK EXECUTION
#-------

# data "aws_iam_policy_document" "ecs_task_execution_policy" {
#   statement {
#     actions = [
#       "ssm:*"
#     ]
#     resources = [
#       "*",
#     ]
#   }
# }
