variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "availability_zone" {
  description = "Availability zone for the subnet and instances"
  type        = string
  default     = "us-east-1a"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  description = "EC2 instance type (t2.micro / t3.micro are free-tier eligible)"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}

variable "key_name" {
  description = "Name of an existing EC2 key pair in your AWS account, used for SSH access"
  type        = string
}

variable "my_ip" {
  description = "Your public IP in CIDR form (e.g. 203.0.113.5/32), allowed to SSH into the instances"
  type        = string
}

variable "project_name" {
  description = "Prefix used to name/tag resources"
  type        = string
  default     = "free-tier-demo"
}
