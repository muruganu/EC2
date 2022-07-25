resource "aws_key_pair" "ssh_key" {
  key_name = "ssh_key"
  public_key = var.key_file
}

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

resource "aws_launch_template" "lt" {
  name = "ec2_lt"
  instance_type = var.instance_type
  key_name = aws_key_pair.ssh_key.id
  user_data = var.user_data
  image_id = data.aws_ami.ec2_image.id
  lifecycle {
    create_before_destroy = true
  }
}


