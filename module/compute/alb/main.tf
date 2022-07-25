resource "aws_alb" "ec2-alb" {
  name = "ec2-alb"
  security_groups = ["${var.alb_sg}"]
  subnets = var.ec2_subnet
}