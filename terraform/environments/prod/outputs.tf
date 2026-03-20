output "alb_dns_name" {
  value = module.alb.alb_dns_name
}

output "web_instance_id" {
  value = module.web_server.instance_id
}

output "linux_agent_instance_id" {
  value = module.linux_agent.instance_id
}

output "windows_agent_instance_id" {
  value = module.windows_agent.instance_id
}

output "artifact_bucket_name" {
  value = module.artifacts.bucket_name
}
