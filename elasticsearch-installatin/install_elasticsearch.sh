#!/bin/bash

set -e

echo "========== STEP 1: Removing existing Elasticsearch =========="

# Stop service if running
sudo systemctl stop elasticsearch || true

# Disable service
sudo systemctl disable elasticsearch || true

# Remove package
sudo apt-get purge -y elasticsearch || true

# Remove leftover directories
sudo rm -rf /etc/elasticsearch
sudo rm -rf /var/lib/elasticsearch
sudo rm -rf /var/log/elasticsearch

echo "Old Elasticsearch versions removed."

echo "========== STEP 2: Installing dependencies =========="

sudo apt-get update
sudo apt-get install -y apt-transport-https wget gnupg

echo "========== STEP 3: Add Elasticsearch GPG key =========="

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo gpg --dearmor -o /usr/share/keyrings/elasticsearch-keyring.gpg

echo "========== STEP 4: Add Elasticsearch repository =========="

echo "deb [signed-by=/usr/share/keyrings/elasticsearch-keyring.gpg] https://artifacts.elastic.co/packages/8.x/apt stable main" | \
sudo tee /etc/apt/sources.list.d/elastic-8.x.list

echo "========== STEP 5: Install Elasticsearch =========="

sudo apt-get update
sudo apt-get install -y elasticsearch

echo "========== STEP 6: Enable & Start Elasticsearch =========="

sudo systemctl daemon-reexec
sudo systemctl enable elasticsearch
sudo systemctl start elasticsearch

echo "========== STEP 7: Check Status =========="

sudo systemctl status elasticsearch --no-pager

echo "========== STEP 8: Verify Elasticsearch =========="

sleep 10
curl -X GET "localhost:9200"

echo "========== DONE =========="
