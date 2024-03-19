from flask import Flask, request
import datetime
import os
from datetime import datetime
from methods.wise_methods import get_transfer_rate, get_time
from methods.log import write_log

APP_LISTENING_PORT = int(os.environ.get('PORT', 5000))

app = Flask(__name__)


@app.route("/")
def app_health():
    response = {
        "servertime": datetime.datetime.now(),
        "success": True
    }
    write_log(
        f"time: {get_time()}, operation: Request, path: {request.url}, returned: {200}")
    return response


@app.route("/rates", methods=['POST'])
def get_transfer_rates():
    source_curr = request.json["from"]
    destination_curr = request.json["to"]
    amount = request.json["amount"]
    transfer_rate = get_transfer_rate(source_curr, destination_curr, amount)
    if transfer_rate:
        response = {
            "message": transfer_rate
        }
        return response
    else:
        error_response = {
            "message": "Error fetching rate. Please try with another currency!"
        }
        return error_response, 400


if __name__ == "__main__":
    app.run(port=APP_LISTENING_PORT, host='0.0.0.0', debug=True)
