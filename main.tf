# Create a VPC for cloudSpace
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = var.tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_classiclink   = var.enable_classiclink
  tags = {
    Name = "main"
  }
}

# Create a Public Subnet
resource "aws_subnet" "main-public-1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnet_1_cidr
  map_public_ip_on_launch = var.map_pub_ip_on_launch_true
  availability_zone       = var.az_a

  tags = {
    Name = "main-public-1"
  }
}

# Create a Public Subnet
resource "aws_subnet" "main-public-2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnet_2_cidr
  map_public_ip_on_launch = var.map_pub_ip_on_launch_true
  availability_zone       = var.az_b

  tags = {
    Name = "main-public-2"
  }
}


# Create an Internet GW
resource "aws_internet_gateway" "main-gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main"
  }
}

# Create route tables
resource "aws_route_table" "main-public-1" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.main-gw.id
  }

  tags = {
    Name = "main-public-1"
  }
}

# Create route associations public
resource "aws_route_table_association" "main-public-1" {
  subnet_id      = aws_subnet.main-public-1.id
  route_table_id = aws_route_table.main-public-1.id
}


resource "aws_security_group" "aws-sc-grp" {
  vpc_id      = aws_vpc.main.id
  name        = "aws-sc-grp"
  description = "security group for my instance"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lb-security-group.id]
  }

  tags = {
    Name = "aws-sc-grp"
  }
}

resource "aws_security_group" "lb-security-group" {
  vpc_id      = aws_vpc.main.id
  name        = "lb-sc-grp"
  description = "security group for load balancer"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "lb-sc-grp"
  }
}