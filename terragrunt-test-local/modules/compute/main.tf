resource "google_compute_instance" "default" {
  name         = var.vm_name
  machine_type = "n2-standard-2"
  zone         = "us-west1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = var.vpc_name

    access_config {
      // Ephemeral public IP
    }
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }
}