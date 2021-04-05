import requests
import json
import time;
import os;

from google.cloud import bigquery

# Set any default values for these variables if they are not found from Environment variables
PROJECT_ID = os.environ.get("GCP_PROJECT", "YOUR-GCP-PROJECT")
OPENEXCHANGERATES_KEY = os.environ.get("OPENEXCHANGERATES_KEY", "YOUR-OPENEXCHANGERATES-APP-ID")
REGIONAL_ENDPOINT = os.environ.get("REGIONAL_ENDPOINT", "us-central1")
DATASET_ID = os.environ.get("DATASET_ID", "currency_rates")
TABLE_NAME = os.environ.get("TABLE_NAME", "openexchangerates_responses")
BASE_CURRENCY = os.environ.get("BASE_CURRENCY", "USD")

def main(request):

    latest_response = get_latest_currency_rates();
    write_to_bq(latest_response)
    return "Success"

def get_latest_currency_rates():
    
    params={'app_id': OPENEXCHANGERATES_KEY , 'base': BASE_CURRENCY}
    response = requests.get("https://openexchangerates.org/api/latest.json", params=params)
    print(response)
    return response.json()

def write_to_bq(response):

    # Instantiates a client
    bigquery_client = bigquery.Client(project=PROJECT_ID)

    # Prepares a reference to the dataset
    dataset_ref = bigquery_client.dataset(DATASET_ID)

    table_ref = dataset_ref.table(TABLE_NAME)
    table = bigquery_client.get_table(table_ref) 

    # get the current timestamp so we know how fresh the data is
    timestamp = time.time()
    # Ensure the Response is a String not JSON
    rows_to_insert = [{"timestamp":timestamp,"data":json.dumps(response)}]

    errors = bigquery_client.insert_rows(table, rows_to_insert)  # API request
    print(response)
    assert errors == []