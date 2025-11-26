resource "google_compute_instance_template" "template" {
  name         = "app-template"
  machine_type = "e2-medium"

  disk {
    source_image = "debian-cloud/debian-11"
    auto_delete  = true
    boot         = true
  }

  metadata_startup_script = file("${path.module}/startup.sh")

  network_interface {
    subnetwork = var.subnet
  }
}

resource "google_compute_region_instance_group_manager" "mig" {
  name               = "app-mig"
  region             = var.region
  base_instance_name = "app-instance"

  version {
    instance_template = google_compute_instance_template.template.id
  }

  target_size = 2
}

output "instance_group" {
  value = google_compute_region_instance_group_manager.mig.instance_group
}
