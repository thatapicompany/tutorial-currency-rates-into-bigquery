
resource "google_storage_bucket" "currency_rates_metadata" {
  name          = "currency-rates-metadata"
  location      = var.location
  storage_class = "REGIONAL"

  labels = {
    product: var.product
  }
}