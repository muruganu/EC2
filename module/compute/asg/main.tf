resource "aws_autoscaling_group" "ec2-asg" {
  name = "ec2-asg"
  max_size = 1
  min_size = 1
  health_check_type = "EC2"
  launch_template {
    id = var.ec2_lt
    version = var.lt_version
  }

  lifecycle {
    create_before_destroy = true
  }
  tag {
    key                 = "Name"
    propagate_at_launch = false
    value               = "EC2_ASG"
  }
}