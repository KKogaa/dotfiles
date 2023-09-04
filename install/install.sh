#!/usr/bin/env bash
# here we will install general pkgs using apt-get
# sudo apt-get install postgresql-client

if ! command -v docker &> /dev/null
then
  echo "Docker could not be found"
  echo "Installing docker"
  pacman -S docker
else
  echo "Docker already installed."
fi

if ! command -v docker-compose &> /dev/null
then
  echo "Docker Compose could not be found"
  echo "Installing docker compose"
  pacman -S docker-compose
else
  echo "Docker Compose already installed."
fi
