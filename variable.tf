variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "ecs_lb_security_group_id" {
  description = "ECS ALB security group ID to allow inbound access from the LB only to Task"
  type        = string
}

#----
#TASK DEFENITION
#----
variable "task_cpu" {
  description = "Task CPU size. Ex: 256 or 512 or 1024 or ..."
  type        = number
}

variable "task_memory" {
  description = "Task memory. Ex: 512 or 1024 or ..."
  type        = number
}

variable "container_definitions" {
  description = "json Container Definition"
  type        = string
}

#-----
#SERVICE
#-----

variable "ecs_service_name" {
  description = "Name the ECS Service"
  type        = string
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

variable "ecs_service_td_desired_count" {
  description = "Number of Task Definition to keep running. Default = 1"
  default     = 1
}

variable "lb_target_group_arn" {
  description = "ARN of ALB Target Group"
  type        = string
}

variable "subnets" {
  description = "Subnets to associate with Task & Service"
  type        = list(string)
}

variable "container_port" {
  description = <<-EOF
  "Container Port to associate with LB, and port mapping in Container Definition.
  Port mappings allow containers to access ports on the host container instance to send or receive traffic."
  EOF
  type        = number
}

variable "container_name" {
  description = "Name of the container to associate with the load balancer (as it appears in a container definition)."
  type        = string
}
