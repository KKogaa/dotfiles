#!/usr/bin/env zsh
# check if java stuff is already installed
curl -s https://get.sdkman.io | zsh
source "/home/$USER/.sdkman/bin/sdkman-init.sh"
sdk install springboot
spring version
