FROM debian:jessie
MAINTAINER David Gersting

LABEL unifi-version="5.0.7"

VOLUME /usr/lib/unifi/data
WORKDIR /usr/lib/unifi
EXPOSE 8443 8080 8880 8843

# Add Unifi config file
COPY unifi.conf /usr/lib/unifi/data/system.properties

# Add MongoDB(EA312927) & Ubiquiti(C0A52C50) repos
COPY repos.list /etc/apt/sources.list.d/repos.list

# Setup container
RUN \
    apt-key adv --keyserver keyserver.ubuntu.com --recv EA312927 2>&1 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 2>&1 && \
    apt-get update -yq && apt-get install -yq net-tools unifi && \
#    useradd -r unifi && \
#    chown -R unifi:unifi /usr/lib/unifi && \
    rm -rf /var/lib/apt/lists/*

# Change to non-privileged user and launch unifi
#USER unifi
CMD ["java", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar", "start"]
