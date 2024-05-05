#!/bin/bash
# entrypoint.sh - This script is the first executed when the container starts.

echo "Starting RimWorld Server Setup..."

# Example of setting up environment variables dynamically
#export SOME_VAR="value"

# Checking if required directories are present and have the right permissions
echo "Checking directories..."
mkdir -p /rimworld/linux-x64
chown root:root /rimworld /rimworld/linux-x64

# Apply migrations or similar tasks
# echo "Applying migrations..."
# dotnet ef database update --project YourProject

# Ensure that all scripts are executable
chmod +x /scripts/*.sh

# This could also be a good place to handle template configurations
# For example, if you have configurations that need to substitute env vars:
# envsubst < /path/to/config.template > /path/to/config

echo "Setup completed. Passing control to CMD."

# Execute the CMD from the Dockerfile, and pass all arguments
exec "$@"
