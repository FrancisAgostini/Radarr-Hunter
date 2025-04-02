# Use a lightweight Alpine Linux base image
FROM alpine:latest

# Install required dependencies
RUN apk add --no-cache \
    bash \
    curl \
    jq

# Set default environment variables
ENV API_KEY="your-api-key" \
    API_URL="http://your-radarr-address:7878" \
    SEARCH_TYPE="both" \
    MAX_MISSING="1" \
    MAX_UPGRADES="5" \
    SLEEP_DURATION="900" \
    RANDOM_SELECTION="true" \
    MONITORED_ONLY="true" \
    STATE_RESET_INTERVAL_HOURS="24" \
    DEBUG_MODE="false"

# Create state directory
RUN mkdir -p /tmp/radarr-hunter-state

# Copy the script into the container
COPY radarr-hunter.sh /usr/local/bin/radarr-hunter.sh

# Make the script executable
RUN chmod +x /usr/local/bin/radarr-hunter.sh

# Set the default command to run the script
ENTRYPOINT ["/usr/local/bin/radarr-hunter.sh"]

# Add labels for better container management
LABEL maintainer="PlexGuide" \
      description="Radarr Hunter - Automates finding missing movies and quality upgrades" \
      version="5.0" \
      url="https://github.com/plexguide/Radarr-Hunter"
