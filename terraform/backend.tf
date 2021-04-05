terraform {
    backend "gcs" {
    bucket      = "YOUR-EXISTING-BUCKET"
    prefix  = "currency-rates/state"
    //credentials = "./serviceaccount.json"  // uncomment if using local creds
  }
}
