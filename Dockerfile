# Antes de criar a imagem docker!!

# RODAR ESSE COMANDO NA RAIS DO SEU PROJETO 
# No powershell

# .\mvnw.cmd package -DskipTests
# Esse comando cria a Arquivo jar do seu projeto ou atualiza!!

# http://localhost:8080/swagger-ui/index.html


# ------------------------------------------------#
# CRIAR IMAGEM DO PROJETO
# docker build -t project-nome .  
# ------------------------------------------------#
# RODAR O CONTEINER DO PROJETO
# docker run -d -p 8080:8080 --name conteiner-nome project-nome
# ------------------------------------------------#

# Runtime
# FROM eclipse-temurin:21-jre-alpine

# WORKDIR /app

# COPY target/*.jar system.jar
# EXPOSE 8080

# ENTRYPOINT ["java","-jar","system.jar"]


# Etapa 1 — Build
FROM maven:3.9-eclipse-temurin-21 AS build

WORKDIR /app

# Copia o pom.xml e as dependências primeiro (otimiza cache)
COPY pom.xml .
RUN mvn dependency:go-offline

# COPIA A PASTA SRC (Onde está o código e os recursos)
COPY src ./src;

# Executa o build
RUN mvn clean package -DskipTests

# # DEBUG (mostra se o jar existe)
RUN ls -la /app/target

# # Etapa 2 — Runtime | Estágio de Execução
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar;
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]