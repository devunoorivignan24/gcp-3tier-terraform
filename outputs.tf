output "load_balancer_ip" {
  value = module.loadbalancer.lb_ip
}

output "cloudsql_connection_name" {
  value = module.cloudsql.connection_name
}
