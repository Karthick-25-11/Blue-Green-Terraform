resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "bg-vpc"
  }
}

resource "aws_subnet" "blue_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.blue_subnet_cidr
  availability_zone       = var.availability_zone_blue
  map_public_ip_on_launch = true

  tags = {
    Name = "blue-subnet"
  }
}

resource "aws_subnet" "green_subnet" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.green_subnet_cidr
  availability_zone       = var.availability_zone_green
  map_public_ip_on_launch = true

  tags = {
    Name = "green-subnet"
  }
}