#####################################
#               EC2                 #
#####################################

resource "aws_instance" "PRD-WEB" {
  ami = "ami-014009fa4a1467d53" #modify
  instance_type = "t3.micro" #modify
  key_name = var.key_name
  source_dest_check = false
  subnet_id = aws_subnet.public-subnets[0].id 
  associate_public_ip_address = true
  #user_data = data.template_file.prd_ap.rendered #modify
  tags = {
    Name = format("%s-%s-WEB",var.company, var.env)
  }
  security_groups = [aws_security_group.WEB.id]
}


# resource "aws_instance" "BICF-PRD-WEB" {
#   count=length(local.private-subnets)
#   ami = "ami-0a0de518b1fc4524c" #modify
#   instance_type = "m5.large" #modify
#   key_name = var.key_name
#   source_dest_check = false
#   subnet_id = aws_subnet.private-subnets[count.index].id
#   #user_data = data.template_file.prd_ap.rendered #modify
#   tags = {
#     Name = format("%s-%s-WEB-%s",var.company, var.env, element(split("", local.private-subnets[count.index].zone), length(local.private-subnets[count.index].zone) - 1))
#   }
#   security_groups = [aws_security_group.web.id]
# }

# resource "aws_instance" "BICF-PRD-FILE" {
#   ami = "ami-0a0de518b1fc4524c" #modify
#   instance_type = "m5.large" #modify
#   key_name = var.key_name
#   source_dest_check = false
#   subnet_id = aws_subnet.private-subnets[1].id
#   #user_data = data.template_file.prd_ap.rendered #modify
#   tags = {
#     Name = format("%s-%s-FILE-%s",var.company, var.env, element(split("", local.private-subnets[1].zone), length(local.private-subnets[1].zone) - 1))
#   }
#   security_groups = [aws_security_group.web.id]
# }

# resource "aws_instance" "BICF-PRD-WEB-TEST" {
#   ami = "ami-0a0de518b1fc4524c" #modify
#   instance_type = "m5.large" #modify
#   key_name = var.key_name
#   source_dest_check = false
#   subnet_id = aws_subnet.test-subnets[0].id
#   #user_data = data.template_file.prd_ap.rendered #modify
#   tags = {
#     Name = format("%s-%s-WEB-TEST-%s",var.company, var.env, element(split("", local.test-subnets[0].zone), length(local.test-subnets[0].zone) - 1))
#   }
#   security_groups = [aws_security_group.web.id]
# }


#####################################
#               SG                  #
#####################################

resource "aws_security_group" "WEB" {
  name        = format("%s-%s-WEB-SG",var.company,var.env)
  description = "WEB"
  vpc_id      = aws_vpc.isnt-vpc.id

  ingress {
    description      = "default"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "default"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-%s-WEB-SG",var.company, var.env)
  }
}

# resource "aws_security_group" "web" {
#   name        = "BICF-WEB"
#   description = "BICF-WEB"
#   vpc_id      = aws_vpc.isnt-vpc.id

#   ingress {
#     description      = "default"
#     from_port        = 22
#     to_port          = 22
#     protocol         = "tcp"
#     security_groups      = [aws_security_group.bastion.id]
#   }

#   ingress {
#     description      = "default"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     security_groups      = [aws_security_group.lb.id]
#   }

#   ingress {
#     description      = "default"
#     from_port        = 443
#     to_port          = 443
#     protocol         = "tcp"
#     security_groups      = [aws_security_group.lb.id]
#   }

#   ingress {
#     description      = "default"
#     from_port        = 3306
#     to_port          = 3306
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = format("%s-%s-web-sg",var.company, var.env)
#   }
# }