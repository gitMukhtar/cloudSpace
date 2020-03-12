#Elastic Load Balancer
/*resource "aws_elb" "my-elb" {
  name            = "my-elb"
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.lb-security-group.id]
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  health_check {
    healthy_threshold   = 10
    unhealthy_threshold = 10
    timeout             = 12
    target              = "HTTP:8080/actuator/health"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}*/

#Application Load Balancer
resource "aws_lb" "myAlb" {
  name               = "myAlb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb-security-group.id]
  subnets            = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "myAlbTG" {
  name = "myAlb-TG"

  port              = 8080
  protocol          = "HTTP"
  vpc_id            = aws_vpc.main.id
  target_type       = "instance"
  health_check {
    protocol        = "HTTP"
    path            = "/actuator/health"
  }
}

resource "aws_lb_listener" "myAlbListener" {
  load_balancer_arn = aws_lb.myAlb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myAlbTG.arn
  }
}