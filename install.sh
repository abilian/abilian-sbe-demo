#!/bin/sh

echo "Creating virtualenv"
virtualenv .
source ./bin/activate

mkdir -p src
cd src

echo "Cloning Abilian SBE source"
git clone https://github.com/sfermigier/abilian-sbe.git

echo "Installing Abilian SBE and dependencies"
cd abilian-sbe
pip install -r etc/deps.txt
pip install -e .

cd ../..

echo "Overriding config"
PWD = `pwd`
echo "\n\nSQLALCHEMY_DATABASE_URI = 'sqlite:///$PWD/var/data.db'" >> var/sbe-demo-instance/config.py

echo "Creating DB"
./manage.py initdb

echo "Creating admin user with email 'admin@example.com' and password 'admin'"
./manage.py createadmin admin@example.com admin

echo "Now type './manage.py run' to launch the server"
