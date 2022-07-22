output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private1_subnet" {
  value = aws_subnet.private1_subnet.id
}

output "private2_subnet" {
  value = aws_subnet.private2_subnet.id
}

output "public1_subnet" {
  value = aws_subnet.public1_subnet.id
}