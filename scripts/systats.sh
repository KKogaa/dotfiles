#!/bin/zsh

CPU=false
MEMORY=false
case $1 in
    -c|--cpu)
        CPU=true
        ;;
    -m|--memory)
        MEMORY=true
        ;;
    *)
        echo "${RED}Error: Invalid option. Use '$0 --help' to see available options.${NC}"
        exit 1
        ;;
esac

if [[ "$CPU" = true ]];then
  echo CPU: $(top -bn1 | awk '/Cpu/ { print $2}')%
fi

if [[ "$MEMORY" = true ]];then
  echo Memory: $(free -m | awk 'NR==2{printf "%s/%sMB\n", $3,$2 }')
fi
