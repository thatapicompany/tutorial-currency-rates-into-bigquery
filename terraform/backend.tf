terraform {
    backend "gcs" {
    bucket      = "YOUR-EXISTING-BUCKET"
    prefix  = var.product + "/state"
    credentials = "./serviceaccount.json"
  }
}
