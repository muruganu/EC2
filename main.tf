module "vpc" {
  source = "./module/vpc"
  vpc_cidr = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
}

module "sg" {
  source = "./module/sg"
  vpc_id = module.vpc.vpc_id
}