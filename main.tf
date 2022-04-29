terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.18.0"
    }
  }
}

provider "google" {
  project = var.project_id
}

resource "google_service_account" "github" {
  account_id   = "github"
  display_name = "GitHub Enterprise Server"
}

resource "google_compute_instance" "github" {
  project = var.project_id

  name = var.name
  zone = var.zone

  machine_type = var.machine_type
  boot_disk {
    initialize_params {
      type  = var.boot_disk_type
      image = var.boot_disk_image
    }
  }

  service_account {
    email  = google_service_account.github.email
    scopes = var.service_account_scopes
  }

  tags = var.tags

  network_interface {
    network = var.network
    access_config {
    }
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }
}

resource "google_compute_disk" "attached_storage" {
  name = var.attached_storage_name
  size = var.attached_storage_size
  type = var.attached_storage_type
  zone = var.zone
}

resource "google_compute_attached_disk" "attached_storage" {
  instance = google_compute_instance.github.id
  disk     = google_compute_disk.attached_storage.id
}

resource "google_compute_firewall" "default" {
  name    = "github"
  network = var.network

  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = [22, 122, 80, 443, 8443]
  }

  target_tags = var.tags
}
