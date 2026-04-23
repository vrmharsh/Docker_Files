java/
└── app/
    │
    ├── backend/                 # Spring Boot (Java)
    │   ├── src/
    │   │   └── main/
    │   │       ├── java/        # Java code (controllers, services, etc.)
    │   │       └── resources/
    │   │           ├── application.properties / application.yml
    │   │           └── static/ (optional)
    │   │
    │   ├── target/              # Build output (JAR) → generated
    │   │   └── app.jar
    │   │
    │   ├── pom.xml              # Equivalent of package.json
    │   ├── Dockerfile
    │   ├── .dockerignore
    │   └── .env (optional)
    │
    └── README.md


#stage-1: build

FROM maven:3.9.6-eclipse-temurin-17 as build

WORKDIR /my-application

COPY pom.xml /my-application/

#download all the dependencies and external plugins
RUN mvn dependency:go-offline

#copy only the source folder othersie pom.xml or other file will also be copied
COPY src ./src

# mvn compiles the code and builds the bundle into a JAR file and we are skipping the unit test since we do not need to test it insdie the container, this will happened earlier.
RUN mvn clean package -Dskiptests


#stage-2: 

FROM maven:3.9.6-eclipse-temurin-17-alpine

WORKDIR /my-app

COPY --from=build /my-application/target/*.jar my-app.jar

EXPOSE 8080

CMD ["java", "-jar", "my-app.jar"]


#dockerignore will have target/ , .git, logs
#any env will be place in dockerignore and git ignore
#we can inject them via docker-compose 
