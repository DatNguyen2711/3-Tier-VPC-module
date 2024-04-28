resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    "Name" = "custom"
  }
}

resource "aws_subnet" "private_app_subnet" {
  count             = length(var.private_app_subnet)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_app_subnet[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]

  tags = {
    "Name" = "private_app_subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_db_subnet" {
  count = length(var.private_db_subnet)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_db_subnet[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]

  tags = {
    "Name" = "private_db_subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "public_web_subnet" {
  count             = length(var.public_web_subnet)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_web_subnet[count.index]
  availability_zone = var.availability_zone[count.index % length(var.availability_zone)]
  
  tags = {
    "Name" = "public_web_subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    "Name" = "my-internet-gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    "Name" = "public-web-rt"
  }
}

resource "aws_route_table_association" "public_association" {
  for_each       = { for k, v in aws_subnet.public_web_subnet : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "public" {
  depends_on = [aws_internet_gateway.ig]

  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_web_subnet[0].id

  tags = {
    Name = "Public NAT Gateway 1",
  }
}

resource "aws_route_table" "public_app_nat_gateway" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    "Name" = "private-app-rt"
  }
}
resource "aws_route_table" "public_db_nat_gateway" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.public.id
  }

  tags = {
    "Name" = "private-db-rt"
  }
}

resource "aws_route_table_association" "private_db_subnet_association" {
  for_each       = { for k, v in aws_subnet.private_db_subnet : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_db_nat_gateway.id
}


resource "aws_route_table_association" "private_app_subnet_association" {
  for_each       = { for k, v in aws_subnet.private_app_subnet : k => v }
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_app_nat_gateway.id
}
