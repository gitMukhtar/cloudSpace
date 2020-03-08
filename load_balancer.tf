#Elastic Load Balancer
resource "aws_elb" "my-elb" {
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
    target              = "HTTP:80/"
    interval            = 60
  }

  cross_zone_load_balancing   = true
  connection_draining         = true
  connection_draining_timeout = 400
  tags = {
    Name = "my-elb"
  }
}

#Application Load Balancer
/*resource "aws_alb" "my-alb" {
  name= "my-alb"
  subnets         = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  security_groups = [aws_security_group.lb-security-group.id]

}
resource "aws_alb_target_group" "alb-target-group" {
  name= "alb-target-group"
  port=80
  protocol = "HTTP"
  vpc_id = aws_vpc.main.id

}
//resource "aws_alb_target_group_attachment" "alb-attachment" {
//  target_group_arn = aws_alb_target_group.alb-target-group.arn
//  target_id =""
//}

resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.my-alb.arn
  port = 80
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb-target-group.arn
  }
}*/