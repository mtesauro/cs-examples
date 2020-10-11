## Setting up Clair for the examples:

Clair uses a database of vulnerabilities to use while scanning images. Luckily, there's a Docker image of the database that is built daily. We're going to use a specific version to ensure the examples are consistent over time, even if new vulnerabilities are discovered.

To get and run the needed database, run the following Docker command:

```
docker run -d --name db arminc/clair-db:2020-10-11
```

Next, the actual Clair scanner will need to be run:

```
docker run -p 6060:6060 --link db:postgres -d --name clair arminc/clair-local-scan:v2.1.6_7830e9c2d00a55cde0bd21a2d837a81ecd415bd2
```

Check to make sure both containers started up cleanly and are ready:

```
docker ps -a
CONTAINER ID  IMAGE                                COMMAND                  CREATED             STATUS             PORTS                              NAMES
84a744a8ea5a  arminc/clair-local-scan:v2.1.6_7...  "/usr/bin/dumb-init …"   34 seconds ago      Up 33 seconds      0.0.0.0:6060->6060/tcp, 6061/tcp   clair
21b42054ca23  arminc/clair-db:2020-10-11           "docker-entrypoint.s…"   About a minute ago  Up About a minute  5432/tcp                           db
```

Note: The very long image name for clair-local-scan was shortened above.

Now, you have everything up and running to be able to scan local images using clair-scanner from https://github.com/arminc/clair-scanner

One thing to note, Clair uses an API and the clair-local-scan needs to connect to that API to get scans done.  The easiest way using the setup above is to just use your computer's IP address. However, you will need to figure that out for yourself since it could be almost any valid IP address. If, for example, the IP of your computer was 10.1.1.57 and you had clair-scanning in the current directory, you would use a command like:

```
./clair-scanner --ip=10.1.1.57 example/app:1.6.7
```

Note: The container image listed above "example/app:1.6.7" is just a placeholder and should be change to the actual container image you want to scan.

Another way to specify the IP address for the Clair API is to use the Docker bridge gateway which can also vary per Docker runtime installation. To determine the IP for the Docker bridge gateway, run the command below: (just the first line is the command)

```
docker network inspect bridge --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}"
172.17.0.1
```

In the example above, the IP 172.17.0.1 can be used to connect to the Clair scanner.  So, the command to scan an image would be:

```
./clair-scanner --ip=172.17.0.1 example/app:1.6.7
```

*Optional*: For those that don't want to type that IP address repeatedly, you can set an environmental variable to hold the IP address.  The below was tested in Bash on Linux.  Your terminal or command prompt may have different method(s) to set environmental variables.

```
CLAIR_IP=$(docker network inspect bridge --format "{{range .IPAM.Config}}{{.Gateway}}{{end}}")
./clair-scanner --ip="$CLAIR_IP" example/app:1.6.7
```

