FROM gradle:8.5-jdk17 AS build
# Set working directory to project root (where gradlew exists)
WORKDIR /home/gradle/project
# Copy entire project root (gradlew, gradle/, settings.gradle.kts, transfer/, etc.)
COPY --chown=gradle:gradle . .
RUN ./gradlew transfer:transfer-00-prerequisites:connector:build --no-daemon
# Production image
FROM eclipse-temurin:17-jre-alpine
# Set working directory
WORKDIR /app
COPY --from=build /home/gradle/project/transfer/transfer-00-prerequisites/connector/build/libs/connector.jar ./connector.jar
# COPY ALL EXTENSIONS
COPY --from=build /home/gradle/project/extensions /app/extensions
# Copy config files (matches README paths)
COPY --from=build /home/gradle/project/transfer/transfer-00-prerequisites/resources/configuration /app/config
# Expose provider ports from config
EXPOSE 19191 19193 19194 19291 19192 19195
# Run
ENTRYPOINT ["java", "-Dedc.fs.config=/app/config/provider-configuration.properties", "-jar", "connector.jar"]
