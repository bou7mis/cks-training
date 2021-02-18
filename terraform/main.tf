provider "google" {
  project = var.project_id
  zone    = var.zone
}

resource "google_compute_address" "master_ip" {
  name = "master-ip"
  address_type = "INTERNAL"
}

resource "google_compute_firewall" "node_ports" {
  name = "nodeports"
  allow {
    protocol = "tcp"
    ports = ["30000-40000"]
  }
  network = "default"
}

data "google_compute_image" "os" {
  project = "ubuntu-os-cloud"
  family  = "ubuntu-1804-lts"
}

resource "google_compute_instance" "cks-master" {
  name         = "cks-master"
  description  = "cks-master"
  machine_type = "e2-medium"

  metadata_startup_script = templatefile("script/cks-master.sh", { bootstrap_token = var.bootstrap_token, master_ip = google_compute_address.master_ip.address, kube_version = var.kube_version })

  boot_disk {
    auto_delete = true

    initialize_params {
      image = data.google_compute_image.os.self_link
      type  = "pd-standard"
      size  = "50"
    }
  }

  network_interface {
    network = "default"
    network_ip = google_compute_address.master_ip.self_link
    access_config {}
  }
}

resource "google_compute_instance" "cks-worker" {
  name         = "cks-worker"
  description  = "cks-worker"
  machine_type = "e2-medium"

  metadata_startup_script = templatefile("script/cks-worker.sh", { bootstrap_token = var.bootstrap_token, master_ip = google_compute_address.master_ip.address, kube_version = var.kube_version })

  boot_disk {
    auto_delete = true

    initialize_params {
      image = data.google_compute_image.os.self_link
      type  = "pd-standard"
      size  = "50"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
}