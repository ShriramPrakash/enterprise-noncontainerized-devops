output "alb_sg_id" { value = aws_security_group.alb_sg.id }
output "linux_web_sg_id" { value = aws_security_group.linux_web_sg.id }
output "linux_agent_sg_id" { value = aws_security_group.linux_agent_sg.id }
output "windows_agent_sg_id" { value = aws_security_group.windows_agent_sg.id }
