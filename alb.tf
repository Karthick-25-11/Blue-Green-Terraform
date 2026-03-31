#ALB
resource "aws_lb" "app_alb" {
  name               = "bg-alb"
  load_balancer_type = "application"
  subnets = [
    aws_subnet.blue_subnet.id,
    aws_subnet.green_subnet.id
  ]
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name = "bg-alb"
  }
}

locals {
  active_tg = var.active_env == "blue" ? aws_lb_target_group.blue.arn : aws_lb_target_group.green.arn
}

#Listener
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.app_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
  type = "forward"

  forward {
    target_group {
      arn    = aws_lb_target_group.blue.arn
      weight = 10
    }

    target_group {
      arn    = aws_lb_target_group.green.arn
      weight = 90
    }
  }
}
}

#Target_Group
#1.Blue_TG
resource "aws_lb_target_group" "blue" {
  name     = "blue-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

#2.Green_TG
resource "aws_lb_target_group" "green" {
  name     = "green-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main_vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

#Attach_EC2_to_TG
resource "aws_lb_target_group_attachment" "blue_attach" {
  target_group_arn = aws_lb_target_group.blue.arn
  target_id        = aws_instance.blue.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "green_attach" {
  target_group_arn = aws_lb_target_group.green.arn
  target_id        = aws_instance.green.id
  port             = 80
}