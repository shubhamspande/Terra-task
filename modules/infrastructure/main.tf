# VPC Creation
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# Subnets
resource "aws_subnet" "dmz" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs["dmz"]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs["web"]
}

resource "aws_subnet" "app" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs["app"]
}

resource "aws_subnet" "db" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.subnet_cidrs["db"]
}

# NAT Gateway for Private Subnets
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "dmz_assoc" {
  subnet_id      = aws_subnet.dmz.id
  route_table_id = aws_route_table.public_rt.id
}

# EC2 Instance in Web Subnet
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.web.id
  private_ip    = "10.0.2.100"
  metadata_options {
    http_tokens = "required" # Enables IMDSv2
  }
  user_data = file("${path.module}/install_apache.sh")
}

# Outputs
output "vpc_id" {
  value = aws_vpc.main.id
}

output "web_subnet_id" {
  value = aws_subnet.web.id
}

output "ec2_private_ip" {
  value = aws_instance.web.private_ip
}
