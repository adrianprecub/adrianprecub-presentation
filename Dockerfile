FROM openjdk:17

ADD target/adrianprecub.jar  adrianprecub.jar
ENTRYPOINT ["java", "-jar","adrianprecub.jar"]
CMD
EXPOSE 8080