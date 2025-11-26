resource "google_compute_backend_service" "backend" {
  name                  = "app-backend"
  load_balancing_scheme = "EXTERNAL"
  backend {
    group = var.instance_group
  }
  health_checks = [google_compute_health_check.health_check.id]
}

resource "google_compute_health_check" "health_check" {
  name = "app-health"
  http_health_check {
    port = 80
  }
}

resource "google_compute_url_map" "urlmap" {
  name            = "app-urlmap"
  default_service = google_compute_backend_service.backend.id
}

resource "google_compute_target_http_proxy" "proxy" {
  name    = "app-proxy"
  url_map = google_compute_url_map.urlmap.id
}

resource "google_compute_global_forwarding_rule" "frontend" {
  name       = "app-frontend"
  target     = google_compute_target_http_proxy.proxy.id
  port_range = "80"
}

output "lb_ip" {
  value = google_compute_global_forwarding_rule.frontend.ip_address
}
