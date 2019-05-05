# CodeChecker on Docker

Run the latest version on CodeChecker with Docker and Docker Compose.

## Requirements
- docker
- docker-compose

## Get started
To build the required images:

```
$ git clone git@github.com:esstorm/codechecker-docker.git
$ cd codechecker-docker
$ docker-compose build
$ docker-compose up
```

You should now be able to open the [CodeChecker Web Viewer]("http://localhost:8001") on your host machine.


A volume __./src__ inside the repo directory is mounted to __/home/casper/src__ inside the container. This is a good place to put the sources for the packages you want to build.

For postgres __./database_data__ is mounted as a volume into __/var/lib/postgresql/data__ on the container


To start a shell inside the codechecker container:

```
# Start a shell
$ docker exec -it codechecker /bin/bash

# Try running CodeChecker
(venv) $ CodeChecker --help
```


## CodeChecker

The official CodeChecker repo can be found here:

[Ericsson/codechecker]("https://github.com/Ericsson/codechecker/")


## Additional scripts used
[vishnubob/wait-for-it]("https://github.com/vishnubob/wait-for-it.git")