FROM openjdk:11-jdk-slim as builder

RUN apt update && apt install maven -y 

COPY . /java_app 
WORKDIR /java_app

RUN mvn clean install


FROM openjdk:11-jdk-slim

COPY --from=builder /java_app/target /java_app/target
COPY --from=builder /java_app/src /java_app/src
COPY --from=builder /java_app/tomcat.8080 /java_app/tomcat.8080
WORKDIR /java_app

EXPOSE 8080

ENTRYPOINT ["sh", "target/bin/webapp"]
