# Upgrading Riak

## Download Riak Versions

```
# 1.4.10
wget http://s3.amazonaws.com/downloads.basho.com/riak/1.4/1.4.10/ubuntu/precise/riak_1.4.10-1_amd64.deb

# 2.0.2
wget http://s3.amazonaws.com/downloads.basho.com/riak/2.0/2.0.2/ubuntu/precise/riak_2.0.2-1_amd64.deb
```

## Vagrant Setup

```
vbox add 'hashicorp/precise64'
vagrant up
vagrant ssh
```

## Install Riak 1.4

```
cd /vagrant

sudo apt-get install curl
sudo apt-get install libpam0g-dev

sudo dpkg -i riak_1.4.10-1_amd64.deb

sudo -s
ulimit -n 65536
riak start

riak ping
```

## Test Data Import

```
# Load Data
./write10.sh

# Read Data
./read10.sh
```

## Upgrade

```
# Stop Riak
riak stop

# Back up the Riak node's /etc and /data directories
sudo tar -czf riak_backup.tar.gz /var/lib/riak /etc/riak

# Upgrade Riak
sudo dpkg -i riak_2.0.2-1_amd64.deb

# Restart Riak
riak start

# Verify Riak is running the new version
riak-admin status | grep version

# Wait for the riak_kv service to start
# <target_node> is the node which you have just upgraded (e.g. riak@192.168.1.11)
riak-admin wait-for-service riak_kv riak@127.0.0.1

# Wait for any hinted handoff transfers to complete
riak-admin transfers

# Repeat the process for the remaining nodes in the cluster
```

## Test Data Read

```
# Read Data
./read10.sh
```