module "vpc" {
  source = "./module/net/vpc"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "sg" {
  source = "./module/net/sg"
  vpc_id = module.vpc.vpc_id
}

module "lt" {
  source = "./module/compute/lt"
  key_file = file("./file/ec2_keys.pub")
  user_data = file("./file/userdata.sh")
  instance_type = var.instance_type
}

module "asg" {
  source = "./module/compute/asg"
  ec2_lt = module.lt.lt_id
  lt_version = module.lt.lt_version
  asg_subnet = data.aws_subnet_ids.private.ids
}

data "aws_subnet_ids" "private" {
  vpc_id = module.vpc.vpc_id
  tags = {
    Name = "*private*"
 }
}

module "alb" {
  source = "./module/compute/alb"
  alb_sg = module.sg.public_sg
  vpc_id = module.vpc.vpc_id
  subnets = data.aws_subnet_ids.private.ids
}


