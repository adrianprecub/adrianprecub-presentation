FROM openjdk:17

RUN groupadd --system spring && useradd --system --gid spring spring
USER spring:spring

COPY target/adrianprecub.jar adrianprecub.jar

EXPOSE 8080

ENTRYPOINT ["java", \
    "-XX:+UseContainerSupport", \
    "-XX:MaxRAMPercentage=75.0", \
    "-Djava.security.egd=file:/dev/./urandom", \
    "-jar", \
    "adrianprecub.jar"]