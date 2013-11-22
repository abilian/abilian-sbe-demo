#!./bin/python

import pexpect
import urllib
import time

# Some random number
PORT = 4034
HOME = "http://0.0.0.0:{}/".format(PORT)

p = pexpect.spawn("./manage.py run -p {}".format(PORT))

try:
  p.expect("Running on {}".format(HOME))
  # Just in case
  time.sleep(5)
  page = urllib.urlopen(HOME).read()
  assert "Welcome to Abilian" in page
finally:
  p.kill(9)
  p.close()

