# data "aws_vpc" "vpc-main" {
#   tags = {
#         Name = format("%s-%s-VPC", var.company, var.env)
#   }
# }

# data "aws_subnet" "public-subnets" {
#   count = length(local.public-subnets)
#   depends_on = [
#     data.aws_vpc.vpc-main
#   ]
#   tags = {
#     Name = format("%s-%s-public-%s", var.company, var.env, local.public-subnets[count.index].zone)
#   }
# }

# data "aws_subnet" "private-subnets" {
#   count=length(local.private-subnets)
#   depends_on = [
#     data.aws_vpc.vpc-main
#   ]
#   tags = {
#     Name = format("%s-%s-private-%s", var.company, var.env, local.private-subnets[count.index].zone)
#   }
# }
