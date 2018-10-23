resource "google_compute_instance_group" "reddit_servers" {
  name        = "reddit-webservers"
  description = "Reddit app instance group"

  instances = ["${google_compute_instance.app.*.self_link}"]

  named_port {
    name = "http"
    port = "9292"
  }

  zone = "${var.zone}"

}

resource "google_compute_health_check" "reddit_health" {
  name               = "reddit-health"
  check_interval_sec = 1
  timeout_sec        = 1

  tcp_health_check {
    port = "9292"
  }
}

resource "google_compute_backend_service" "reddit_backend" {
  name             = "reddit-backend"
  description      = "Reddit Backend"
  protocol         = "HTTP"
   port_name   = "http"
  timeout_sec      = 10

  backend {
    group = "${google_compute_instance_group.reddit_servers.self_link}"
  }

  health_checks = ["${google_compute_health_check.reddit_health.self_link}"]
}

resource "google_compute_url_map" "reddit_url_map" {
    name = "reddit-url-map"
    default_service = "${google_compute_backend_service.reddit_backend.self_link}"
}

resource "google_compute_target_http_proxy" "reddit_proxy" {
  name        = "reddit-proxy"
  url_map     = "${google_compute_url_map.reddit_url_map.self_link}"
}

resource "google_compute_global_forwarding_rule" "reddit_rule" {
  name       = "reddit-rule"
  target     = "${google_compute_target_http_proxy.reddit_proxy.self_link}"
  port_range = "80"
}
