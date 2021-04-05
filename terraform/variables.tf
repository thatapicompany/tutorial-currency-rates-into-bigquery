variable "project" {
  type    = string
  default = "YOUR-GCP-PROJECT"
}

variable "location" {
  type    = string
  default = "us-central1"
}

variable "dataset" {
  type    = string
  default = "currency_codes"
}
variable "product" {
  type    = string
  default = "currency-rates-etl"
}

variable "OPENEXCHANGERATES_KEY" {
  type    = string
  default = "YOUR-OPENEXCHANGERATES-APP-ID"
}

variable "BASE_CURRENCY" {
  type    = string
  default = "USD"
}
