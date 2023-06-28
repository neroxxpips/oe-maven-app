FROM openjdk:8-jdk-alpine

WORKDIR /app

COPY target/oe-maven-app.jar oe-maven-app.jar

CMD ["java", "-jar", "oe-maven-app.jar"]
