output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_app_subnet_ids" {
  value = aws_subnet.private_app_subnet[*].id
}

output "private_db_subnet_ids" {
  value = aws_subnet.private_db_subnet[*].id
}

output "public_web_subnet_ids" {
  value = aws_subnet.public_web_subnet[*].id
}

output "internet_gateway_id" {
  value = aws_internet_gateway.ig.id
}

output "nat_gateway_id" {
  value = aws_nat_gateway.public.id
}
