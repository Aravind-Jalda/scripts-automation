#!/bin/bash

set -e

echo "========================================"
echo " Java Cleanup & Installation Script"
echo "========================================"

# Step 1: Remove all existing Java versions
echo "Removing existing Java versions..."

sudo apt-get purge -y openjdk-* || true
sudo apt-get purge -y oracle-java* || true
sudo apt-get autoremove -y
sudo apt-get clean

# Remove any leftover directories
sudo rm -rf /usr/lib/jvm/*
sudo rm -rf /etc/java*

echo "Old Java versions removed."

# Step 2: Update system
echo "Updating package list..."
sudo apt-get update -y

# Step 3: Install Java 21 (OpenJDK)
echo "Installing OpenJDK 21..."
sudo apt-get install -y openjdk-21-jdk

# Step 4: Verify installation
echo "Verifying Java installation..."
java -version

# Step 5: Set JAVA_HOME
echo "Setting JAVA_HOME..."

JAVA_PATH=$(readlink -f $(which java) | sed "s:/bin/java::")

echo "Detected JAVA_HOME: $JAVA_PATH"

# Add to environment variables
echo "export JAVA_HOME=$JAVA_PATH" | sudo tee /etc/profile.d/java.sh
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/profile.d/java.sh

# Apply changes
source /etc/profile.d/java.sh

echo "JAVA_HOME set to $JAVA_HOME"

echo "========================================"
echo " Java 21 Installation Completed"
echo "========================================"
