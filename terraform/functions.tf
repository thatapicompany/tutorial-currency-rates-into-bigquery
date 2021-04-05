
data "archive_file" "get_currency_rates_function_zipped_code" {
  type        = "zip"
  output_path = "../files/get-currency-rates.zip"
  source_dir = "../functions/get-currency-rates/"
}
variable "get_currency_rates_function_file" {
  type    = string
  default = "../functions/get-currency-rates/main.py"
}

resource "google_storage_bucket_object" "get_currency_rates_function_code" {
  name   = "GetCurrencyRates-v3${substr(md5(file(var.get_currency_rates_function_file)), 0, 8)}.zip"
  bucket = google_storage_bucket.currency_rates_metadata.name
  source = "../files/get-currency-rates.zip"
}

resource "google_cloudfunctions_function" "get_currency_rates_function" {

  name                      = "get-latest-currency-rates"
  description               = "Gets the latest currency rates and saves the API response to BigQuery to be parsed by the a view later"
  entry_point               = "main"
  trigger_http          = true

  runtime                   = "python38"
  timeout                   = 120
  max_instances             = 1
  source_archive_bucket     = google_storage_bucket.currency_rates_metadata.name
  source_archive_object     = google_storage_bucket_object.get_currency_rates_function_code.name
  
  labels = {
    product: var.product
  }

  environment_variables = {
    OPENEXCHANGERATES_KEY = var.OPENEXCHANGERATES_KEY
    BASE_CURRENCY = var.BASE_CURRENCY
  }
}

resource "google_service_account" "service_account" {
  account_id   = "cloud-function-invoker"
  display_name = "Cloud Function Tutorial Invoker Service Account"
}

resource "google_cloudfunctions_function_iam_member" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
  member = "serviceAccount:${google_service_account.service_account.email}"
}

output "function_url" {
  value = "${google_cloudfunctions_function.function.https_trigger_url}"
}