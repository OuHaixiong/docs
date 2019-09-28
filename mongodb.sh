



mkdir -p /data/db/mongodb
mkdir -p /data/logs/mongodb/
touch /data/logs/mongodb/mongodb.log

echo "/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/bin/mongodb.conf" >> /etc/rc.local