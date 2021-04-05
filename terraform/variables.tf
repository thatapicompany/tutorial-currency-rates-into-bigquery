variable "project" {
  type    = string
  default = "YOUR-GCP-PROJECT-ID"
}

variable "location" {
  type    = string
  default = "australia-southeast1"
}

variable "dataset" {
  type    = string
  default = "currency_rates"
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
