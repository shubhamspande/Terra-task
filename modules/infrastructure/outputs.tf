output "vpc_id" {
  value = module.infrastructure.vpc_id
}

output "web_subnet_id" {
  value = module.infrastructure.web_subnet_id
}

output "ec2_private_ip" {
  value = module.infrastructure.ec2_private_ip
}
