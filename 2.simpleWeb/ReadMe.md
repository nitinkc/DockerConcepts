# Build the docker image

```shell
docker build -t nitinkc/simple-web-app:latest .
```

# Run the image to make it a container

```dockerfile
docker run \
	--name=simple_webapp \
	-d \
	-p 8080:3000 nitinkc/simple-web-app
```

# Stop container from command prompt

The Docker Desktop provides much more intuitive interface to manage containers and images

```dockerfile
docker stop simple_webapp
```

# Start an existing container 

```dockerfile
docker start simple_webapp
```
