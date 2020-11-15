import time
from subprocess import check_call
from urllib.request import urlopen

check_call("docker run --rm --name=smk -p 8080:80 -d httpd".split())
# Wait for the server to start. A better implementation
# would poll in a loop:
time.sleep(5)
# Check if the server started (it'll throw an exception
# if not):
try:
    urlopen("http://localhost:8080").read()
finally:
    check_call("docker kill smk".split())
