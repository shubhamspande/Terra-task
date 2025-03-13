variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidrs" {
  description = "CIDR blocks for subnets"
  type        = map(string)
  default = {
    dmz = "10.0.1.0/24"
    web = "10.0.2.0/24"
    app = "10.0.3.0/24"
    db  = "10.0.4.0/24"
  }
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID"
  default     = "ami-0abcdef1234567890" # Replace with correct AMI
}
