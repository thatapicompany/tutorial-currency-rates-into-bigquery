
resource "google_cloud_scheduler_job" "daily_currency_rates_etl" {
  name        = "Trigger-Get-Latest-Currency-Rates"
  description = "Every night get the latest currency rates"
  schedule    = "0 0 * * *"
  time_zone   = "Europe/London"

  retry_config {
    retry_count = 1
  }

  http_target {
    http_method = "POST"
    body        = base64encode("{\"foo\":\"bar\"}")
    uri         = google_cloudfunctions_function.function.https_trigger_url

    oidc_token {
      service_account_email = google_service_account.service_account.email
    }
  }

  depends_on = [google_cloudfunctions_function.get_currency_rates_function]
}