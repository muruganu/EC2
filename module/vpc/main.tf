#-------VPC------------------

resource "aws_vpc" "vpc" {
  enable_dns_hostnames = true
  enable_dns_support = true
  cidr_block = var.vpc_cidr
  tags = {
    Name = "my_vpc"
  }
}

#Availability zones

data "aws_availability_zones" "available" {
  state = "available"
}

#-------Private Subnet------------------

resource "aws_subnet" "private1_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr["private1_cidr"]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "private1_subnet"
  }
}

resource "aws_subnet" "private2_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr["private2_cidr"]
  map_public_ip_on_launch = false
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "private2_subnet"
  }
}

resource "aws_subnet" "public1_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnet_cidr["public1_cidr"]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "public1_subnet"
  }
}