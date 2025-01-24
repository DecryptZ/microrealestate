# Use Docker-in-Docker image for Docker support
FROM docker:20.10.7-dind

# Install curl and bash to fetch necessary files
RUN apk add --no-cache curl bash

# Set the working directory
WORKDIR /app

# Fetch the necessary files (docker-compose.yml and .env.domain)
RUN curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/docker-compose.yml -o docker-compose.yml && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/.env.domain -o .env

# Set environment variables for your custom domain and protocol
ENV APP_DOMAIN=https://microrealestate-xpcf.onrender.com
ENV APP_PROTOCOL=https

# Manually build the Docker image using the docker-compose.yml configuration
# This command builds the image directly from the docker-compose.yml context
RUN docker build -f docker-compose.yml -t microrealestate .

# Run the application directly using the Docker run command
CMD docker run -p 8080:8080 microrealestate
