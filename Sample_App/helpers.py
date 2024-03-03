import requests

wise_base_url = 'https://api.transferwise.com/v3'
rates = []


def get_rate(sourceCurrency, desintationCurrency, amount):
    reponse_data = requests.get(
        f'{wise_base_url}/comparisons/?sourceCurrency={sourceCurrency}&targetCurrency={desintationCurrency}&sendAmount={amount}')
    if reponse_data.status_code == 200:
        json_contnet = reponse_data.json()
        rates = json_contnet['providers']
        return rates
