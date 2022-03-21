resource "google_compute_instance_template" "default" {

  name        = "instance-template-${var.target_size}"
  description = "This template is used to create app server instances."

  tags = ["foo", "bar"]

  labels = {
    environment = var.environment
  }

  instance_description = "description assigned to instances"
  machine_type         = "e2-medium"
  can_ip_forward       = false

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
  }



  // Create a new boot disk from an image
  disk {
    source_image = "debian-cloud/debian-9"
    auto_delete  = true
    boot         = true
    // backup the disk every day
    resource_policies = [google_compute_resource_policy.daily_backup.id]
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata = {
    foo            = "bar"
    startup-script = "sudo apt-get update && sudo apt-get install -y nginx"
  }



  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "google_compute_resource_policy" "daily_backup" {
  name   = "every-day-4am"
  region = "us-central1"
  snapshot_schedule_policy {
    schedule {
      daily_schedule {
        days_in_cycle = 1
        start_time    = "04:00"
      }
    }
  }
}

resource "google_compute_health_check" "autohealing" {
  name                = "autohealing-health-check"
  check_interval_sec  = 5
  timeout_sec         = 5
  healthy_threshold   = 2
  unhealthy_threshold = 10 # 50 seconds

  http_health_check {
    request_path = "/"
    port         = "80"
  }
}

resource "google_compute_instance_group_manager" "appserver" {
  name = "${google_compute_instance_template.default.name}-group-manager"

  base_instance_name = google_compute_instance_template.default.name
  zone               = "us-central1-a"
  target_size        = var.target_size


  version {
    instance_template = google_compute_instance_template.default.id
  }



  named_port {
    name = "customhttp"
    port = 80
  }

  auto_healing_policies {
    health_check      = google_compute_health_check.autohealing.id
    initial_delay_sec = 300
  }
  depends_on = [google_compute_instance_template.default]
}
