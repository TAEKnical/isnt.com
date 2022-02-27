# ###########################################################
# #                        ALB
# ###########################################################
# resource "aws_lb_target_group" "tg" {
#   name     = "SMC-TG"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.vpc-main.id
# }

# resource "aws_lb_target_group_attachment" "tg-attach" {
#   count = length(aws_instance.SMC-PRD-WEB)
#   target_group_arn = aws_lb_target_group.tg.arn
#   target_id        = aws_instance.SMC-PRD-WEB[count.index].id
#   port             = 80
# }

# resource "aws_lb_listener" "listner" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn
#   }

# #   default_action {
# #     type = "redirect"

# #     redirect {
# #       port        = "443"
# #       protocol    = "HTTPS"
# #       status_code = "HTTP_301"
# #     }
# #   }
# }

# resource "aws_lb" "alb" {
#   name               = "SMC-ALB"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.lb.id]
#   subnets            = [aws_subnet.public-subnets[0].id,aws_subnet.public-subnets[1].id]

#   tags = {
#     Name = format("%s-%s-ALB",var.company,var.env)
#   }
# }

# resource "aws_security_group" "lb" {
#   name        = "SMC-lb"
#   description = "SMC-lb"
#   vpc_id      = aws_vpc.vpc-main.id

#   ingress {
#     description      = "default"
#     from_port        = 80
#     to_port          = 80
#     protocol         = "tcp"
#     cidr_blocks      = ["0.0.0.0/0"]
#   }

#   ingress {
#     description      = "default"
#     from_port        = 443
#     to_port          = 443
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
#     Name = format("%s-%s-lb-sg",var.company, var.env)
#   }
# }
