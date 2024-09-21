resource "aws_lb" "lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.HTTP-SG.id]
  subnets            = [aws_subnet.private-sub1.id,aws_subnet.private-sub2.id]


  tags = {
    Name = "load-balancer"
  }
}
resource "aws_lb_target_group" "targetgroup" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
  health_check {
    path = "/"
    port = 80
    protocol = "HTTP"
  }
}
resource "aws_lb_listener" "lb-listener" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgroup.arn
  }
}
