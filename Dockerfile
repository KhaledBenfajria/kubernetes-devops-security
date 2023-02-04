FROM openjdk:8-jdk-alpine
EXPOSE 8080
ARG JAR_FILE=target/*.jar
ADD ${JAR_FILE} numeric-0.0.1.jar
ENTRYPOINT ["java","-jar","/numeric-0.0.1.jar"]
