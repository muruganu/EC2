#--VPC Outputs-------
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private1_subnet" {
  value = module.vpc.private1_subnet
}

output "private2_subnet" {
  value = module.vpc.private2_subnet
}

output "public1_subnet" {
  value = module.vpc.public1_subnet
}

#---Security Group-----------

output "public_sg" {
  value = module.sg.public_sg
}


