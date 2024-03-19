import json
from flask import jsonify
import requests
import os

LOCAL_GRAYLOG_BASE_URL = 'http://graylog'
GRAYLOG_GELF_TCP_PORT = int(os.environ.get('TCP_PORT', 12201))


def write_log(message):
    # using the GELF TCP port
    headers = {
        'Content-Type': 'application/json'
    }
    json_content = json.dumps({
        "message": message
    })
    is_written = requests.post(
        f'{LOCAL_GRAYLOG_BASE_URL}:{GRAYLOG_GELF_TCP_PORT}/gelf', data=json_content, headers=headers, verify=False)
    if is_written.status_code != 202:
        print(f"Error writting to graylog server. Received {is_written.status_code}.")
