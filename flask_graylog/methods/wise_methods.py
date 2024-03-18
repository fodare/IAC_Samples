import requests
from datetime import datetime
from methods.log import write_log

WISE_BASE_URL = 'https://api.transferwise.com/v3'


def get_time():
    return str(datetime.now())


def get_transfer_rate(source_currency, destination_currency, amount):
    response_data = requests.get(
        f'{WISE_BASE_URL}/comparisons/?sourceCurrency={source_currency}&targetCurrency={destination_currency}&sendAmount={amount}')
    if response_data.status_code == 200:
        write_log(
            f"time: {get_time()}, operation: Request, remoteUrl: {response_data.url},Received:{response_data.status_code}")
        json_content = response_data.json()
        rates = json_content['providers']
        return rates
    else:
        write_log(
            f"time: {get_time()}, operation: Request, rempteUrl: {response_data.url}, Received:{response_data.status_code}")
    return None
