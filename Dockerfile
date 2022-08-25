FROM openjdk:17
ARG USER=notused
ARG PASSWORD=notused
ARG ROLES=notused

ENV USER=$USER
ENV PASSWORD=$PASSWORD
ENV ROLES=$ROLES
ADD target/adrianprecub.jar  adrianprecub.jar
ENTRYPOINT ["java", "-jar","adrianprecub.jar"]
EXPOSE 8080