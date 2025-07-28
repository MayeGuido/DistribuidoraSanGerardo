FROM maven:3.8.5-openjdk-17 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM openjdk:17.0.1-jdk-slim
COPY --from=build /app/target/tienda-1.jar tienda.jar
EXPOSE 80
ENTRYPOINT ["java", "-jar", "tienda.jar"]