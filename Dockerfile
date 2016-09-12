FROM debian
MAINTAINER David Gersting

LABEL unifi-version="5.0.7"

VOLUME ["/data/mongodb", "/data/unifi"]
EXPOSE 8443 8080 8880 8843

# Add MongoDB & Ubiquiti repos
ADD configs/repos.list /etc/apt/sources.list.d/repos.list

# Install software
RUN \
  apt-key adv --keyserver keyserver.ubuntu.com --recv EA312927 2>1 && \
  apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 2>1 && \
  apt-get update -y && \
  apt-get upgrade -y && \
  apt-get install -y uuid unifi supervisor && \
  apt-get autoremove -y && \
  apt-get clean

# Setup data directories
RUN \
  mkdir -p /data/mongodb /data/unifi /usr/lib/unifi/data && \
  rmdir /usr/lib/unifi/data && \
  ln -s /data/unifi /usr/lib/unifi/data

# Add MongoDB config file
ADD configs/mongodb.conf /etc/mongodb.conf

# Add Supervisor config file
ADD configs/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add Unifi config file & setup unifi data directory
ADD configs/unifi.conf /data/unifi/system.properties

# Start supervisord
CMD ["/usr/bin/supervisord"]
