#!./bin/python

import pexpect
import urllib

p = pexpect.spawn("./manage.py run")

try:
  p.expect("Running on http://0.0.0.0:5000/")
  page = urllib.urlopen("http://0.0.0.0:5000/").read()
finally:
  p.kill(9)
  p.close()

