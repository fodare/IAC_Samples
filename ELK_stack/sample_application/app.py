from flask import Flask, url_for
from datetime import datetime
import os
import requests
from elasticsearch import Elasticsearch as _es


app = Flask(__name__)
app_port = int(os.environ.get('APP_Port', 5000))
app.config['SECRET_KEY'] = f"{os.environ.get('APP_Secret')}"
elk_ports = os.environ.get('ELK_PORTS')
elk_password = os.environ.get('ELK_PASSWORD')
elk_username = os.environ.get('ELK_USERNAME')
elk_host_ip = os.environ.get('ELK_HOST_IP')

ELK_NODES = []
for port in elk_ports.split(","):
    ELK_NODES.append(f"https://{elk_host_ip}:{int(port)}")


def log_to_elk_instance(message):
    try:
        client = _es(ELK_NODES, verify_certs=False,
                     basic_auth=(elk_username, elk_password))
        doc = {
            'timestamp': datetime.now(),
            'message': message
        }
        resp = client.index(index="test-index", document=doc)
        print(resp['result'])
    except Exception as err:
        print(f"Error posting to ELK instance. Exception: {err}")


@ app.route("/country/<string:name>", methods=['GET'])
def home(name):
    new_index = {'tag': "country", 'value': name}
    log_to_elk_instance(new_index)
    return new_index


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=app_port)
