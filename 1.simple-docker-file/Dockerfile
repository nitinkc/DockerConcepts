# Use an existing docker image as a base
FROM openjdk:21-jdk

# Take the file from host machine into the container. (.) is current directory w.r.t Dockerfile is located
# `/usr/src/myapp` : destination path inside the Docker image
COPY ./java_files /usr/src/java/myapp

# the absolute path set the working directory
WORKDIR /usr/src/java/myapp

RUN javac *.java

CMD ["java", "HelloWorld"]
CMD ["java", "Calculator", "add", "5", "3"]