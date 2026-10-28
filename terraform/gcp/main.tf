locals {
  network_name = "${var.name_prefix}-${var.environment}-vpc"
  subnet_name  = "${var.name_prefix}-${var.environment}-subnet"
  common_labels = {
    environment = var.environment
    owner       = "platform-engineering"
    application = "enterprise-platform"
    managed_by  = "terraform"
  }
}

resource "google_project_service" "required_apis" {
  for_each = toset([
    "compute.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ])

  project            = var.project_id
  service            = each.value
  disable_on_destroy = false
}

resource "google_compute_network" "foundation" {
  name                    = local.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  depends_on              = [google_project_service.required_apis]
}

resource "google_compute_subnetwork" "workload" {
  name                     = local.subnet_name
  project                  = var.project_id
  region                   = var.region
  network                  = google_compute_network.foundation.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  depends_on = [google_project_service.required_apis]
}

# Internal east-west traffic only. No internet-wide SSH/RDP ingress is created.
resource "google_compute_firewall" "allow_internal" {
  name      = "${local.network_name}-allow-internal"
  project   = var.project_id
  network   = google_compute_network.foundation.name
  direction = "INGRESS"
  priority  = 1000

  source_ranges = [var.subnet_cidr]
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "icmp"
  }
  depends_on = [google_project_service.required_apis]
}
