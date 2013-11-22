#!/bin/sh

GIT_SRC=git@github.com:sfermigier/abilian-sbe.git

# Exit on firts error
set -e

echo "Creating virtualenv"
virtualenv .
. ./bin/activate

mkdir -p src
cd src

if [ ! -d abilian-sbe ]
then
  echo "Cloning Abilian SBE source"
  git clone $GIT_SRC
else
  cd abilian-sbe
  git pull
  cd ..
fi

echo "Installing Abilian SBE and dependencies"
cd abilian-sbe
pip install -r etc/deps.txt
pip install -e .

cd ../..

if [ ! -f var/sbe-demo-instance/config.py ]
then
  echo "Creating, then twekaing config"
  ./manage.py config init
  PWD=`pwd`
  echo "\n\nSQLALCHEMY_DATABASE_URI = 'sqlite:///$PWD/var/data.db'" >> var/sbe-demo-instance/config.py
fi

if [ ! -f var/data.db ]
then
  echo "Creating DB"
  ./manage.py initdb

  echo "Creating admin user with email 'admin@example.com' and password 'admin'"
  ./manage.py createadmin admin@example.com admin
fi

echo "Now type './manage.py run' to launch the server"
