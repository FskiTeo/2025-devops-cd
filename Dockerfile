FROM eclipse-temurin:21-jdk AS builder

WORKDIR /app

COPY . .

RUN ./mvnw clean package

RUN mv target/*.jar target/myApp.jar

ENTRYPOINT ["java", "-jar", "/app/target/myApp.jar"]

FROM eclipse-temurin:21-jre AS runtime

WORKDIR /app

COPY --from=builder /app/target/myApp.jar .

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "myApp.jar"]