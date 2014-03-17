#!/usr/bin/python
from urllib2 import Request, urlopen

import subprocess

# Get the docker0 interface IP address.
result = subprocess.check_output("ip route show", shell=True)
docker_ip = result.split()[2]

# Check active Mongo connections
result = subprocess.check_output("mongostat -n 1", shell=True)
active_connections = int(result.split()[-2]) - 1 # subtract one for this connection

# POST the active connections to the spin-docker client
req = Request('http://%s/v1/check-in' % docker_ip, data='active=%s' % active_connections)
try:
    resp = urlopen(req)
except Exception:
    pass
