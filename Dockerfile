FROM mcr.microsoft.com/dotnet/sdk:3.1
LABEL maintainer="f00d4tehg0dz <adrianvfx@gmail.com>"

ENV HOME=/app \
    OS_ARCH=amd64 \
    OS_FLAVOUR=debian-10 \
    ADDITIONAL_OPTS="" \
    TZ="America/New_York" \
    GAME_PORT=25555 \
    K8=False

# Install necessary packages, including .NET Core 3.1 and tools for handling downloads and zip files
RUN wget -q https://packages.microsoft.com/config/ubuntu/19.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install -y apt-transport-https aspnetcore-runtime-3.1 build-essential ca-certificates unzip curl tzdata && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /packages-microsoft-prod.deb

# Setting up directories and permissions
RUN mkdir -p /rimworld /scripts /linux-x64 && \
    chown -R root:root /rimworld /scripts /linux-x64

# Adding the script and setting correct permissions
COPY start.sh /scripts/start.sh
RUN chmod +x /scripts/start.sh

# Setting the entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose ports
EXPOSE $GAME_PORT/udp
EXPOSE $GAME_PORT/tcp

# Volume declaration
VOLUME /rimworld

# Define the entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash", "/scripts/start.sh"]
