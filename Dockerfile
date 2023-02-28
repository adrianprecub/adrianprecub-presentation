FROM openjdk:17

RUN --mount=type=secret,id=my_env source /run/secrets/my_env

ADD target/adrianprecub.jar  adrianprecub.jar
ENTRYPOINT ["java", "-jar","adrianprecub.jar"]
CMD
EXPOSE 8080