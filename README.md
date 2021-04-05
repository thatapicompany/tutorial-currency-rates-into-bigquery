# Tutorial on how to automate a daily ETL of currency rates into BigQuery
Code for our Tutorials on how to automate adding currency rates into BigQuery via a manual setup or using Terraform

Step by Step guide how to add each piece via the Google Cloud Console:
- https://blog.thereportapi.com/automate-a-daily-etl-of-currency-rates-into-bigquery/

# Terraform setup

I'm assuming you're already fluent with Terraform.

- Update the "backend.tf" with the name of one of your GCS buckets to hold the state. This is better practice than holding it locally.
- 