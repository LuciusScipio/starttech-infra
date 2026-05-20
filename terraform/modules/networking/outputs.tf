output "vpc_id" { value = aws_vpc.main.id }
output "public_subnets" { value = aws_subnet.public[*].id }
output "backend_sg_id" { value = aws_security_group.backend_sg.id }
output "alb_target_group_arn" { value = aws_lb_target_group.backend.arn }
output "alb_dns_name" { value = aws_lb.main.dns_name }