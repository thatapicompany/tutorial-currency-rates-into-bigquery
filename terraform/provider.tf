provider "google" {
  credentials = file("./serviceaccount.json")
  project     = var.project
  region      = var.location
}