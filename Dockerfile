FROM maven:3.6.3-jdk-8 as maven

WORKDIR /usr/src/app

COPY src ./src
COPY pom.xml ./

RUN ls

RUN mvn package

FROM openjdk:8-jre-alpine

WORKDIR /usr/src/bytebin

COPY --from=maven /usr/src/app/target/bytebin.jar ./
COPY config.json ./

EXPOSE 80

ENTRYPOINT ["/usr/bin/java", "-jar", "bytebin.jar"]
