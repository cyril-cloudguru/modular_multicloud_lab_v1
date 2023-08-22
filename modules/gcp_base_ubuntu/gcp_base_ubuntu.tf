terraform {
  required_providers {
    gcp = {
      source  = "hashicorp/google"
      version = "~> 4.7"
    }
  }
}

# Configure the GCP Provider
provider "gcp" {
  region = var.region1
  project = var.project1_name
}




resource "google_project" "project1" {
  name       = var.project1_name
  project_id = var.project1_name
}

resource "google_compute_network" "vpc1" {
  name    = var.vpc1_name
  project = var.project1_name
  auto_create_subnetworks = false
  depends_on = [ 
    google_project.project1 
    ]
}

resource "google_compute_subnetwork" "sub1" {
  name          = var.subnet1_name
  ip_cidr_range = var.cidr1
  region        = var.region1
  network       = google_compute_network.vpc1.id
}

#resource "google_service_account" "default" {
#  account_id   = "service_account_id"
#  display_name = "Service Account"
#}

resource "google_compute_instance" "vm1" {
  name         = var.vm1_name
  machine_type = "e2-medium"



  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = google_compute_subnetwork.sub1.id
    network_ip = var.privip1

    access_config {
      // Ephemeral public IP
    }
  }


  metadata_startup_script = "echo hi > /test.txt"

#  service_account {
#    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
#    email  = google_service_account.default.email
#    scopes = ["cloud-platform"]
#  }
}