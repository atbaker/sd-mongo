# Spin-docker example dockerfile for MongoDB
# https://github.com/atbaker/spin-docker | http://www.mongodb.org/

# Use phusion/baseimage as base image
FROM phusion/baseimage:0.9.8

MAINTAINER Andrew T. Baker <andrew@andrewtorkbaker.com>

# Set correct environment variables
ENV HOME /root

# Use the phusion baseimage's insecure key
RUN /usr/sbin/enable_insecure_key

# Install MongoDB
# Add 10gen official apt source to the sources list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/10gen.list

# Install MongoDB
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mongodb-10gen
RUN mkdir -p /data/db
RUN chown -R mongodb:mongodb /data
RUN echo "bind_ip = 0.0.0.0" >> /etc/mongodb.conf

# Create a runit entry for your app
RUN mkdir /etc/service/mongo
ADD run_mongo.sh /etc/service/mongo/run
RUN chown root /etc/service/mongo/run

# Add a spin-docker client to report Mongo connection activity to spin-docker
ADD sd_mongo_client.py /opt/sd_client.py
ADD sd_client_crontab /var/spool/cron/crontabs/root
RUN chown root /opt/sd_client.py /var/spool/cron/crontabs/root

# Clean up APT when done
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Spin-docker currently supports exposing port 22 for SSH and
# one additional application port (Mongo runs on 27017)
EXPOSE 22 27017

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]
