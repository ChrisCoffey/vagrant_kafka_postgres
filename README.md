# vagrant_kafka_postgres
A Vagrant file to generate a stand-alone Kafka &amp; Postgres environment

## Getting started

Install [Vagrant](http://www.vagrantup.com/downloads.html), then [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
run
```
    $.../vagrant_kafka_postgres> vagrant up
```

This will do the following:
 1.  Download a Ubuntu 14.04 x64 VirtualBox image
 2.  Load that image into your VirtualBox install
 3.  Ensure the image is accessible on your network at **192.168.33.10**
 3.  Provision it with all the packages you'll need for Ubuntu 14.04
 4.  Ensure Java 7 is installed (open jdk)
 5.  Download & unpack Kafka to */vagrant/app*
 6.  Generate configuration files for Kafka & Zookeeper to */vagrant/app/config*
 7.  Generate start & stop scripts for Kafka & Zookeeper in */vagrant/app/bin*
 8.  Install the postgres 9.3 package
 9.  Create a user & database named **test** with password **test**
 10.  Start Kafka & Zookeeper

The first time you run this script it may take a few minutes while everything downloads and installs. But once you're done you'll have a fully-operational single-node ZK cluster & Kafka cluster. If you want to play with it, you'll notice there's now an */app* folder in the root repository directory. You can start up the Kafka producer/consumer or Zookeeper clients by running the .sh scripts in *Kafka_DIR/bin*. 


## Reporting Issues
Please report any issues via the repo's issue tracker. I'll keep an eye on it, I promise.
