# ============================================================================
# BIGQUERY DATASETS
# ============================================================================

resource "google_bigquery_dataset" "dataset" {
  dataset_id    = var.dataset
  description   = "Holds all currency rate data"
  friendly_name = var.dataset
  location      = var.location
  depends_on    = [google_project_service.bigquery-json, google_project_service.bigquerystorage]
}


resource "google_bigquery_table" "openexchangerates_responses" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "openexchangerates_responses"
  description   = "Holds all the API responses from OpenExchangeRates as JSON strings"
  schema     = file("../bigquery/openexchangerates_responses.json")

  time_partitioning {
    field                    = "timestamp"
    type                     = "DAY"
    require_partition_filter = "false"
  }

  labels = {
    product: var.product
  }
}

resource "google_bigquery_table" "latest_currency_rates" {
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "latest_currency_rates"
  description ="Get the latest currency rates"
  view {
    query          = file("../bigquery/latest_currency_rates.sql")
    use_legacy_sql = "false"
  }

  depends_on = [google_bigquery_dataset.dataset]
}
