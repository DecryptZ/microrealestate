# Use the Docker-in-Docker image, which includes Docker
FROM docker:20.10.7-dind

# Install curl to fetch the necessary files
RUN apk add --no-cache curl bash

# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

# Set the working directory
WORKDIR /app

# Make the directory and fetch the necessary files (docker-compose.yml and .env)
RUN mkdir -p mre && cd mre && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/docker-compose.yml -o docker-compose.yml && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/.env.domain -o .env

# Run the docker-compose command with the correct environment variables
CMD APP_DOMAIN=https://microrealestate-xpcf.onrender.com APP_PROTOCOL=https docker-compose --profile local up
