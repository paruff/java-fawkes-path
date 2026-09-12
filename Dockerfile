# Multi-stage Dockerfile for Java Spring Boot
# Stage 1: Build
FROM maven:3.9.16-eclipse-temurin-21 AS build
WORKDIR /app

# Copy pom.xml and download dependencies (layer caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code and build
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:21.0.11_10-jre-alpine
WORKDIR /app

# Update packages and install netcat for healthcheck
RUN apk upgrade --no-cache && \
    apk add --no-cache netcat-openbsd && \
    rm -rf /var/cache/apk/*

# Copy JAR from build stage
COPY --from=build /app/target/*.jar app.jar

# Run as UID/GID 65534 (the "nobody" account already present in this base
# image, matching the runAsUser/runAsGroup: 65534 convention this project's
# Kubernetes securityContexts use elsewhere) - no addgroup/adduser needed,
# and none possible: GID/UID 65534 is already taken by the image's
# pre-existing nobody account, so creating a *new* user at that ID fails
# (confirmed live: `addgroup -g 65534 appuser` errored with GID already
# in use).
RUN chown -R 65534:65534 /app
USER 65534:65534

# Expose port
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=40s --retries=3 \
  CMD nc -z localhost 8080 || exit 1

# Run application
ENTRYPOINT ["java", "-jar", "app.jar"]
