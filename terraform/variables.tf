variable "project" {
  type    = string
  default = "landmarks-datalake"
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
  default = "a418ccd747424498b587ad3176b598fe"
}

variable "BASE_CURRENCY" {
  type    = string
  default = "USD"
}
