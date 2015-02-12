#!/bin/bash

baseDir=/vagrant/app
userName="test"

apt-get install openjdk-7-jre -y

# Download and unpack kafka

KafkaVersion="0.8.2.0"
ScalaVersion="2.11"
if [ ! -f /vagrant/app/kafka_2.11-0.8.2.0.tgz ]; then
	echo Downloading kafka...
	kafkaFull="kafka_$ScalaVersion-$KafkaVersion"
	wget "http://www.us.apache.org/dist/kafka/$KafkaVersion/$kafkaFull.tgz" -P $baseDir
	mkdir -p "$baseDir/$kafkaFull"
	tar -xvf "$baseDir/$kafkaFull.tgz" -C "$baseDir/"

	if [ ! -d /tmp/zookeeper ]; then
		mkdir -p /tmp/zookeeper
		echo "1" > /tmp/zookeeper/myid
	fi
fi

# finally something simple
apt-get install postgresql -y



# Create the configuration files

confDir="$baseDir/config"
mkdir "$confDir"

echo "broker.id=0
port=9092
host.name=192.168.33.10
num.network.threads=2
num.io.threads=2
socket.send.buffer.bytes=1048576
socket.receive.buffer.bytes=1048576
socket.request.max.bytes=804857600
log.dirs=/tmp/kafka-logs
num.partitions=1
log.retention.hours=168
log.segment.bytes=536870912
log.retention.check.interval.ms=60000
zookeeper.connect=192.168.33.10:2181
zookeeper.connection.timeout.ms=1000000
log.cleanup.policy=delete" > "$confDir/server.properties"

echo "dataDir=/tmp/zookeeper
clientPort=2181
maxClientCnxns=0
tickTime=2000
initLimit=5
syncLimit=2
server.1=192.168.33.10:2888:3888" > "$confDir/zookeeper.properties"



# Create Start and stop scripts

runDir="$baseDir/bin"
mkdir "$runDir"

echo "$baseDir/$kafkaFull/bin/zookeeper-server-start.sh $confDir/zookeeper.properties > /tmp/zookeeper.log &" > "$runDir/zk.sh"
echo "$baseDir/$kafkaFull/bin/zookeeper-server-stop.sh" > "$runDir/stopzk.sh"

echo "$baseDir/$kafkaFull/bin/kafka-server-start.sh $confDir/server.properties &" > "$runDir/kafka.sh"
echo "$baseDir/$kafkaFull/bin/kafka-server-stop.sh " > "$runDir/stopkafka.sh"

# Configure Postgres

echo 'host	all	all	all	trust' >> /etc/postgresql/9.3/main/pg_hba.conf
echo "listen_addresses = '*' " >> /etc/postgresql/9.3/main/postgresql.conf
sudo -u postgres psql -c "Create User $userName with password '$userName';"
sudo -u postgres createdb pos -O $userName
sudo /etc/init.d/postgresql restart


sudo sh "$runDir/zk.sh"
sudo sh "$runDir/kafka.sh"


