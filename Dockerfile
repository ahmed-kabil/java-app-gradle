RUN eclipse-temurin:17-jdk-alpine
WORKDIR /app
COPY ./build/libs/*.war app.war
ARG PORT=8050
EXPOSE ${PORT}
ENV PORT=${PORT}
CMD ["java","-jar","app.war","--server.port=${PORT}"]