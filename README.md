# Containerized Unifi Controller

## Data Container
The data container sits in the background and stores the data for the unifi controller. The data will persist so long as this container is not removed.
```
docker create --name unifi_data dgersting/unifi /bin/true
```

##  Unifi controller
The controller container is where the Unifi Controller actually runs from. Data is persisted in the data container, and because of that this container becomes ephemeral and be spun up / spun down / even removed without worry.
```
 docker run -d \
   --name=unifi \
   --volumes-from=unifi_data \
   --restart=unless-stopped \
   --memory="512m" \
   -p SERVER_IP:443:8443 \
   -p SERVER_IP:8080:8080 \
   -p SERVER_IP:8880:8880 \
   -p SERVER_IP:8843:8843 \
   dgersting/unifi
```
