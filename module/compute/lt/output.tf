output "ssh_key" {
  value = aws_key_pair.my_key.id
}

output "ec2_image" {
  value = data.aws_ami.ec2_image.id
}

output "instance_type" {
  value = aws_launch_template.lt.instance_type
}

output "lt_id" {
  value = aws_launch_template.lt.id
}

output "lt_version" {
  value = aws_launch_template.lt.latest_version
}