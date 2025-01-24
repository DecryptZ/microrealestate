# Use a basic image with curl and Docker Compose
FROM alpine:latest

# Install curl and docker-compose
RUN apk add --no-cache curl bash \
    && curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose \
    && chmod +x /usr/local/bin/docker-compose

# Set the working directory
WORKDIR /app

# Make the directory and fetch the required files
RUN mkdir -p mre && cd mre && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/docker-compose.yml -o docker-compose.yml && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/.env.domain -o .env

# Start the application with docker-compose
CMD cd mre && APP_PORT=8080 docker-compose --profile local up
