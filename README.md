# Purpose:
To create ECS Task Definition, ECS Service.     

## Variable Inputs:

- namespace                 (ex: project name)
- environment               (ex: dev/prod)
- task_cpu                  CPU size (ex: 512)
- task_memory               Memory size (ex: 1024)
- container_definitions     module.container.cd_json
- ecs_service_name          Name the ECS Service
- cluster_id                module.ecs-cluster.cluster_id
- lb_target_group_arn       module.alb.alb_target_group_arn
- subnets                   module.network.public_subnet_ids
- container_port            Container port to associate with ALB Target Group. (ex: 80)
- container_name            Name of the container to associate with the load balancer.
- vpc_id                    module.network.vpc_id
- ecs_lb_security_group_id  module.alb.ecs_lb_security_group_id

OPTIONAL:

- ecs_service_td_desired_count  Number of Task Definition to keep running. Default = 1.

## Resources created:

- aws_ecs_service
- aws_ecs_task_definition
- aws_security_group (allowing ingress fron ALB)
- aws_iam_policy: task_execution_policy, task_policy.
- aws_iam_role: task_execution_role, task_role.               

## Resources naming convention:

- IAM Role: Task & Task Execution: namespace-environment-ecsTaskRole
    ex: sg-dev-ecsTaskRole, sg-dev-ecsTaskExecutionRole
- IAM policy: Task & Task Execution: namespace-environment-ecs-task-policy
    ex: sg-dev-task-execution-policy, sg-test-ecs-task-policy
- Security Group: namespace-environment-ecs-task
    ex: sg-dev-ecs-task

# Steps to create the resources

1. Call the "ecs-task-definition-service" module from your tf code.
3. Specifying Variable Inputs along the module call.
4. Apply.

Example:

```
module "ecs-td-service
  source      = "git@github.com:nohamkumar/aws-ecs-task-definition-service.git"
  namespace   = "stg"
  environment = "dev"

  #td
  task_cpu              = 512
  task_memory           = 1024
  container_definitions = module.container.cd_json

  #service
  ecs_service_name    = "nodeJs"
  cluster_id          = module.ecs-cluster.cluster_id
  lb_target_group_arn = module.alb.alb_target_group_arn
  subnets             = module.network.public_subnet_ids
  container_port      = 80
  container_name      = "server"

  vpc_id                   = module.network.vpc_id
  ecs_lb_security_group_id = module.alb.ecs_lb_security_group_id

  depends_on = [
    module.ecs-cluster,
  ]
}


```

3. From terminal: 

```
terraform init
```
```
terraform plan
```
```
terraform apply
```


---


##OUTPUTS

```

#-----
#TASK DEFINITION
#-----

task_definition_arn
  description = "ECS Task Definition ARN"

task_security_group_id
  description = "ID of security group attached to ECS Task. Allows ingress from the LB only, egress all port"

#-----
#SERVICE
#-----

serivce_name
  description = "ECS service name"

#-----
#TASK IAM
#-----

task_iam_role_name
  description = "Name of the IAM role for ECS Task."

#-----
#TASK EXECUTION IAM
#-----

task_execution_iam_role_name
  description = "Name of the IAM role for ECS Task Execution."

  
```
