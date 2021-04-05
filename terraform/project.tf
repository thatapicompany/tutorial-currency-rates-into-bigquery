/*
Uncomment if first time used these APIs on the GCP project

resource "google_project_service" "bigquery-json" {
  project = var.project
  service = "bigquery.googleapis.com"
}

resource "google_project_service" "bigquerystorage" {
  project = var.project
  service = "bigquerystorage.googleapis.com"
}

resource "google_project_service" "cloudfunctions" {
  project = var.project
  service = "cloudfunctions.googleapis.com"
}
*/