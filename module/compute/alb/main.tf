resource "aws_alb" "ec2-alb" {
  name = "ec2-alb"
  security_groups = ["${var.alb_sg}"]
  enable_cross_zone_load_balancing = true
  subnets = var.subnets
}

# Target group for the web servers
resource "aws_lb_target_group" "web_servers" {
  name     = "ec2-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_alb.ec2-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_servers.arn
  }
}

