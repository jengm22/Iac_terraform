resource "aws_lb" "iac-lb" {
  provider           = aws.master
  name               = "iac-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-sg.id]
  subnets            = [aws_subnet.subneta.id, aws_subnet.subnetb.id]
  tags = {
    Name = "Iac-Test-LB"
  }
}

resource "aws_lb_target_group" "iac-lb-tg" {
  provider    = aws.master
  name        = "iac-lb-tg"
  port        = var.webserver-port
  target_type = "instance"
  vpc_id      = aws_vpc.sand.id
  protocol    = "HTTP"
  health_check {
    enabled  = true
    interval = 10
    path     = "/"
    port     = var.webserver-port
    protocol = "HTTP"
    matcher  = "200-299"
  }
  tags = {
    Name = "iac-target-group"
  }
}

resource "aws_lb_listener" "iac-listener-http" {
  provider          = aws.master
  load_balancer_arn = aws_lb.iac-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.iac-lb-tg.id
  }
}

resource "aws_lb_target_group_attachment" "mahtarrs-master-attach" {
  provider         = aws.master
  count            = var.master-count
  target_group_arn = aws_lb_target_group.iac-lb-tg.arn
  target_id        = aws_instance.mahtarrs-master[count.index].id
  port             = var.webserver-port
}