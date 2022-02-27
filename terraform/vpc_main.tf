#####################################
#               VPC                 #
#####################################
resource "aws_vpc" "isnt-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
      Name = format("%s-%s-VPC", var.company, var.env)
  }
}

#####################################
#              Subnet               #
#####################################

resource "aws_subnet" "public-subnets" {
  count = length(local.public-subnets)
  vpc_id     = aws_vpc.isnt-vpc.id
  cidr_block = local.public-subnets[count.index].cidr
  availability_zone = local.public-subnets[count.index].zone

  tags = {
      Name = format("%s-%s-public-%s", var.company, var.env, element(split("", local.public-subnets[count.index].zone), length(local.public-subnets[count.index].zone) - 1))
  }
}

# resource "aws_subnet" "private-subnets" {
#   count = length(local.private-subnets)
#   vpc_id     = aws_vpc.isnt-vpc.id
#   cidr_block = local.private-subnets[count.index].cidr
#   map_public_ip_on_launch = false
#   availability_zone = local.private-subnets[count.index].zone

#   tags = {
#       Name = format("%s-%s-private-%s", var.company, var.env, element(split("", local.private-subnets[count.index].zone), length(local.private-subnets[count.index].zone) - 1))
#   }
# }

# resource "aws_subnet" "db-subnet" {
#   count = length(local.db-subnets)
#   vpc_id     = aws_vpc.isnt-vpc.id
#   cidr_block = local.db-subnets[count.index].cidr
#   map_public_ip_on_launch = false
#   availability_zone = local.db-subnets[count.index].zone

#   tags = {
#       Name = format("%s-%s-db-%s", var.company, var.env, element(split("", local.db-subnets[count.index].zone), length(local.db-subnets[count.index].zone) - 1))
#   }
# }

#####################################
#              GW                   #
#####################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.isnt-vpc.id

  tags = {
      Name = format("%s-%s-igw", var.company, var.env)
  }
}

# resource "aws_eip" "ngw-eip" {
#   vpc   = true
#   depends_on = [aws_internet_gateway.igw]
#   tags = {
#       Name = format("%s-%s-ngw-eip", var.company, var.env)
#   }
# }

# resource "aws_nat_gateway" "ngw" {
#   allocation_id = aws_eip.ngw-eip.id
#   subnet_id     = aws_subnet.public-subnets[0].id

#   tags = {
#       Name = format("%s-%s-ngw", var.company, var.env)
#   }
# }

#####################################
#              RT                   #
#####################################
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.isnt-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
      Name = format("%s-%s-public-rt", var.company, var.env)
  }
}

# resource "aws_route_table" "private-rt" {
#   vpc_id = aws_vpc.isnt-vpc.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_nat_gateway.ngw.id
#   }

#   # route {
#   #   cidr_block = "10.0.0.0/16" //<input> vpn 연결하려는 idc 내부 대역
#   #   gateway_id = aws_vpn_gateway.sungwoo-vpn-gw.id
#   # }

#   tags = {
#       Name = format("%s-%s-private-rt", var.company, var.env)
#   }
# }

resource "aws_route_table_association" "public-association" {
  count = length(local.public-subnets)
  subnet_id      = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
}

# resource "aws_route_table_association" "private-association" {
#   count = length(local.private-subnets)
#   subnet_id      = aws_subnet.private-subnets[count.index].id
#   route_table_id = aws_route_table.private-rt.id
# }