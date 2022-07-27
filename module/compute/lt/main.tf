resource "aws_key_pair" "my_key" {
  key_name = "mynew_key"
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

data "template_file" "userdata" {
  template = <<EOF
    sudo mkdir /tmp/test
    sudo yum update -y
    sudo amazon-linux-extras install nginx1 -y
    sudo systemctl enable nginx
    sudo systemctl start nginx
  EOF
}

resource "aws_launch_template" "lt" {
  name = "ec2_lt"
  instance_type = var.instance_type
  key_name = aws_key_pair.my_key.id

  user_data = "${base64encode(data.template_file.userdata.rendered)}"

  image_id = data.aws_ami.ec2_image.id
  vpc_security_group_ids = ["${var.sg_name}"]
  lifecycle {
    create_before_destroy = true
  }
}


