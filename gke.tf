data "google_container_engine_versions" "gke_versions" {
  location       = var.region
  version_prefix = "1.21."
}

resource "google_container_cluster" "cluster" {
  name               = "${var.project_id}-cluster"
  location           = var.gke_zone
  min_master_version = data.google_container_engine_versions.gke_versions.latest_master_version

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name
}

resource "google_container_node_pool" "blue_nodes" {
  name       = "${google_container_cluster.cluster.name}-blue"
  location   = var.gke_zone
  cluster    = google_container_cluster.cluster.name
  node_count = var.gke_num_nodes
  version    = data.google_container_engine_versions.gke_versions.latest_node_version

  node_config {
    labels = {
      env = var.project_id
    }

    preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }
}

resource "google_container_node_pool" "green_nodes" {
  name       = "${google_container_cluster.cluster.name}-green"
  location   = var.gke_zone
  cluster    = google_container_cluster.cluster.name
  node_count = var.gke_num_nodes
  version    = data.google_container_engine_versions.gke_versions.latest_node_version

  node_config {
    labels = {
      env = var.project_id
    }

    preemptible  = true
    machine_type = "n1-standard-1"
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 1
  }
}
