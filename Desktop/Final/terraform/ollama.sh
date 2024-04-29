#!/bin/bash

# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io

# Install Ollama
sudo docker run -d -p 8000:8000 --name=ollama --restart=always ollama/ollama