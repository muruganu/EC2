data "aws_ami" "ec2_image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

data "template_file" "userdata" {
  template = file("${path.module}/userdata.sh")
}

resource "aws_launch_template" "lt" {
  name = "ec2_lt"
  instance_type = var.instance_type
  key_name = "mykey"
  user_data = "${base64encode(data.template_file.userdata.rendered)}"
  image_id = data.aws_ami.ec2_image.id
  vpc_security_group_ids = ["${var.sg_name}"]
  lifecycle {
    create_before_destroy = true
  }
}