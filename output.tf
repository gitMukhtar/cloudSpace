#output "ELB" {
#  value = aws_elb.my-elb.dns_name
#}
output "alb_dns_name" {
  value = aws_alb.my-alb.dns_name

}
output "alb_target_group_arn" {
  value = aws_alb_target_group.alb-target-group.arn
}