import mmh3
import requests
import base64

response = requests.get("https://128.183.160.251/favicon.ico",verify=False)
favicon = base64.encodebytes(response.content)
hash_value = mmh3.hash(favicon)

print(hash_value)
