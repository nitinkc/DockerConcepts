# Use an existing docker image as a base
FROM openjdk:21-jdk
#FROM scratch

# Take the file from host machine into the container. (.) is current directory w.r.t Dockerfile is located
# `/usr/src/myapp` : destination path inside the Docker image
COPY ./java_files /usr/src/java/myapp

# the absolute path set the working directory
WORKDIR /usr/src/java/myapp

RUN javac *.java

# Docker only allows one CMD instruction per Dockerfile, and it should be the last instruction, as it specifies the default command to run when the container starts

# Run HelloWorld
CMD ["java", "HelloWorld"]

# Run Calculator with add operation
CMD ["java", "Calculator", "add", "5", "3"]