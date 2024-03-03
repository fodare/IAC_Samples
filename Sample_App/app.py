from flask import Flask, request, render_template, url_for
import requests
from helpers import get_rate
import os

app = Flask(__name__)
app_listening_port = int(os.environ.get('PORT', 5000))


@app.route("/", methods=['GET', 'POST'])
def get_wise_comparison():
    if request.method == 'GET':
        return render_template('index.html')
    else:
        sourceCurrency = request.form['sourceCurrency']
        destinationCurrency = request.form['destinationCurrency']
        amount = request.form['amount']
        wisePartnerRates = get_rate(
            sourceCurrency, destinationCurrency, amount)
        return render_template('index.html', partnerRates=wisePartnerRates)


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=app_listening_port)
