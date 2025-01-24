# Use Docker-in-Docker image for Docker support
FROM docker:20.10.7-dind

# Install curl to fetch necessary files
RUN apk add --no-cache curl bash

# Set the working directory
WORKDIR /app

# Make the directory and fetch the necessary files
RUN mkdir -p mre && cd mre && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/docker-compose.yml -o docker-compose.yml && \
    curl https://raw.githubusercontent.com/microrealestate/microrealestate/master/.env.domain -o .env

# Set environment variables for your custom domain and protocol
ENV APP_DOMAIN=https://microrealestate-xpcf.onrender.com
ENV APP_PROTOCOL=https

# Start the application manually (replace `docker-compose` with `docker` command)
CMD cd mre && docker build -t microrealestate . && docker run -p 8080:8080 microrealestate
