#!/bin/zsh

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m'

REACTIVE=false
WEBFLUX=false
STANDARD=false
MAVEN=false
case $1 in
    -r|--reactive-create)
        REACTIVE=true
        ;;
    -w|--webflux-create)
        WEBFLUX=true
        ;;
    -s|--standard-create)
        STANDARD=true
        ;;
    -m|--maven-create)
        MAVEN=true
        ;;
    -h|--help) echo "Usage: $0 [-w|--webflux-create] [-s|--standard-create]"
        echo "Options:"
        echo "  -w, --webflux-create : Create a project with WebFlux dependencies"
        echo "  -s, --standard-create : Create a standard project without WebFlux"
        exit 0
        ;;
    *)
        echo "${RED}Error: Invalid option. Use '$0 --help' to see available options.${NC}"
        exit 1
        ;;
esac

# full reactive
if [[ "$REACTIVE" = true ]];then
  echo "${GREEN} Creating webflux project named: $2 with group $3 at location $4 ${NC}"
  (cd $4/ && spring init --dependencies=webflux,data-r2dbc,lombok --build=gradle --type=gradle-project --java-version=17 --packaging=jar --artifact-id=$2 --group-id=$3 --name=$2 $2) 
fi

# webflux  
if [[ "$WEBFLUX" = true ]];then
  echo "${GREEN} Creating web project named: $2 with group $3 at location $4 ${NC}"
  (cd $4/ && spring init --dependencies=webflux,data-jpa,postgresql,lombok --build=gradle --type=gradle-project --java-version=17 --packaging=jar --artifact-id=$2 --group-id=$3 --name=$2 $2) 
fi

if [[ "$STANDARD" = true ]];then
  echo "${GREEN} Creating web project named: $2 with group $3 at location $4 ${NC}"
  (cd $4/ && spring init --dependencies=web,data-jpa,postgresql,lombok --build=gradle --type=gradle-project --java-version=17 --packaging=jar --artifact-id=$2 --group-id=$3 --name=$2 $2) 
fi

if [[ "$MAVEN" = true ]];then
  echo "${GREEN} Creating maven project named: $2 with group $3 at location $4 ${NC}"
  (cd $4/ && mvn archetype:generate -DgroupId=$3 -DartifactId=$2 -DarchetypeArtifactId=maven-archetype-quickstart -DarchetypeVersion=1.4 -DinteractiveMode=false) 
fi


