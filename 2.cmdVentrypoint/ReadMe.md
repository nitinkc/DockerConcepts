* CMD is used for defining the default behavior of the container, 
* while ENTRYPOINT is used to specify the main executable command of the container
  * can be combined with additional commands when the container is run


```shell
docker build -t nitinkc/simple-docker-test .
docker run --name docker-test nitinkc/simple-docker-test:latest
```

## Overriding CMD of the Dockerfile

Only the CMD is affected, while the ENTRYPOINT always executes from Dockerfile regardless of the command provided.

```shell
docker run --name docker-test nitinkc/simple-docker-test:latest `echo '\n overriding Dockerfile CMD'` 
 ```

* Run an existing container `docker start docker-test` - check the logs OR 
* check the `DockerDesktop -> container -> Run container -> select container -> logs`

