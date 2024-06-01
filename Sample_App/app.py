from flask import Flask, request, render_template, url_for, make_response
import platform
import socket
import datetime
import requests
from helpers import get_rate
import os

app = Flask(__name__)
app_listening_port = int(os.environ.get('PORT', 5000))

app_version = os.environ.get('app_version', "V.0.1")


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


@app.route("/resource", methods=['GET'])
def get_app_resource_info():
    system_status = {
        "serverName": socket.gethostname(),
        "platform": platform.system(),
        "serverTime": datetime.datetime.now(),
        "appVersion": app_version
    }
    return render_template('resourceInfo.html', systemInfo=system_status)


if __name__ == "__main__":
    app.run(port=app_listening_port)
