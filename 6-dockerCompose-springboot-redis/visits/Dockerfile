# Stage 1: Build the application
FROM gradle:8.4-jdk21-alpine AS build
WORKDIR /app
COPY build.gradle settings.gradle gradlew /app/
COPY gradle /app/gradle
RUN ./gradlew --no-daemon dependencies
COPY . .
RUN ./gradlew --no-daemon build

# Stage 2: Create the final image
FROM gradle:8.4-jdk21-alpine
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]

