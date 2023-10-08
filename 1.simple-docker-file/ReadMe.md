```shell
docker rm simple_javaapp
docker rmi nitinkc/simple-java-app
docker build -t nitinkc/simple-java-app .

docker run \
  --name=simple_javaapp \
  nitinkc/simple-java-app
  
# Run in a new container each time  
docker run nitinkc/simple-java-app 
```

Passing ARGS 
```shell
CMD ["java", "Calculator", "add", "5", "3"]

```
