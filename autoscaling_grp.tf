resource "aws_launch_configuration" "launch_config" {
  name_prefix = "launch_config"
  image_id = var.AMIS[var.AWS_REGION]
  instance_type = var.INSTANCE_TYPE
  key_name = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.aws-sc-grp.id]

}
resource "aws_autoscaling_group" "auto_scaling_grp" {
  name                      = "auto_scaling_grp"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.launch_config.name
  min_size                  = var.ins_min_size
  max_size                  = var.ins_max_size
  health_check_grace_period = var.hltchk_grace_period
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.my-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "auto_scaling_grp"
    propagate_at_launch = true
  }
}

# scale up alarm

resource "aws_autoscaling_policy" "as_cpu_policy" {
  name                   = "as_cpu_policy"
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_grp.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "as_cpu_alarm" {
  alarm_name          = "as_cpu_alarm"
  alarm_description   = "as_cpu_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.auto_scaling_grp.name
  }

  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.as_cpu_policy.arn]
}

# scale down alarm
resource "aws_autoscaling_policy" "as_cpu_policy-scaledown" {
  name                   = "as_cpu_policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.auto_scaling_grp.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "as_cpu_alarm-scaledown" {
  alarm_name          = "as_cpu_alarm-scaledown"
  alarm_description   = "as_cpu_alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "5"

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.auto_scaling_grp.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.as_cpu_policy-scaledown.arn]
}


