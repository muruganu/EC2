module "vpc" {
  source = "./module/net/vpc"
  vpc_cidr = var.vpc_cidr
  private_cidr = var.private_cidr
  public_cidr = var.public_cidr
}

module "sg" {
  source = "./module/net/sg"
  vpc_id = module.vpc.vpc_id
}

module "lt" {
  source = "./module/compute/lt"
  instance_type = var.instance_type
  depends_on = [module.vpc]
  sg_name = module.sg.public_sg
}

module "asg" {
  source = "./module/compute/asg"
  ec2_lt = module.lt.lt_id
  lt_version = module.lt.lt_version
  asg_subnet = data.aws_subnets.private.ids
  depends_on = [module.lt]
}

/*
data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "*private*"
 }
  depends_on = [module.vpc]
}
*/
data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*private*"] # insert values here
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
  filter {
    name   = "tag:Name"
    values = ["*public*"] # insert values here
  }
}

module "alb" {
  source = "./module/compute/alb"
  alb_sg = module.sg.public_sg
  vpc_id = module.vpc.vpc_id
  subnets = data.aws_subnets.public.ids
  depends_on = [module.asg]
  asg_id = module.asg.asg_id
}


