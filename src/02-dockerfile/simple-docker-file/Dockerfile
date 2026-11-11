# Use an existing docker image as a base
FROM openjdk:21-jdk
#FROM scratch

# Take the file from host machine into the container. (.) is current directory w.r.t Dockerfile is located
# `/usr/src/myapp` : destination path inside the Docker image
COPY ./java_files /usr/src/java/myapp

# the absolute path set the working directory
WORKDIR /usr/src/java/myapp

RUN javac *.java

# Docker only allows ONE effective CMD per Dockerfile — the LAST one wins.
# Keep one active CMD; switch behavior by overriding at `docker run` time instead.

# Run Calculator with add operation (default)
CMD ["java", "Calculator", "add", "5", "3"]
