#!/bin/bash -ex
# Start script for Rimworld called from docker# Start script for Rimworld called from docker

# Fetch the latest release URL for LinuxX64
curl -L -o /rimworld/linux-x64.zip https://github.com/D12-Dev/OpenWorld/releases/download/v1.0.4/linux-x64.zip
if [ $? -ne 0 ]; then
  echo "Failed to download file"
  exit 1
fi

containerIP=$(hostname -i)

cd /rimworld

# Ensure version.txt exists and set permissions correctly
if [ ! -f "version.txt" ]; then
	touch version.txt
	chmod 777 version.txt
	echo "0.0.0" > version.txt
else
	chmod 777 version.txt
fi

LocalVersion=$(cat version.txt)

# Pull if not updated
if [ "${RemoteVersion}" != "${LocalVersion}" ]; then
    # Download the latest release of LinuxX64
    curl -L -o /rimworld/linux-x64.zip https://github.com/D12-Dev/OpenWorld/releases/download/v1.0.4/linux-x64.zip
    if [ $? -eq 0 ]; then
        echo "Download successful."
        unzip -o /rimworld/linux-x64.zip -d /rimworld
        # Check if 'Open World Server' executable exists after unzipping
        if [ -f "/rimworld/linux-x64/OpenWorldServer" ]; then
            chmod 755 '/rimworld/linux-x64/OpenWorldServer'
            chmod +x '/rimworld/linux-x64/OpenWorldServer'
            echo "${RemoteVersion}" > version.txt
        else
            echo "'OpenWorldServer' not found in the zip file."
            exit 1
        fi
    else
        echo "Failed to download the file."
        exit 1
    fi
fi

# Update config with IP
if [ -f "/rimworld/linux-x64/Server Settings.txt" ]; then
	sed -i "s/^Server Local IP:.*/Server Local IP: ${containerIP}/" '/rimworld/linux-x64/Server Settings.txt'
fi

# Run server
if [ "${K8}" == "true" ]; then
    # Non-interactive
    /rimworld/linux-x64/OpenWorldServer > "Logs/$(date +%m%d%Y-%H%M).term.log"
else    
    /rimworld/linux-x64/OpenWorldServer
fi
