#!/usr/bin/env bash

GREEN='\033[0;32m'
YELLOW="\033[0;33m"
RED="\033[0;31m"
CYAN="\033[0;36m"
NC='\033[0m'

EXCEPT_DIRS=("tmux")


walk_dir_names() {
  local -n directory_list=$1
  directory_list=()
  while IFS= read -r -d '' dir; do
    if [[ "$dir" != "./" && "$dir" != "./.git" ]]; then
      #remove the ./ prefix
      dir=${dir#./}
      directory_list+=("${dir%/}")
    fi
  done < <(find . -mindepth 1 -maxdepth 1 -type d -print0)
}

dir_exists(){
  if [ -d "${HOME}/.config/$1" ]; then
    echo -e "${RED}[ERROR] Found ${1} directory already exists.${NC}"
    return 1
  fi
  return 0
}

dir_in_exclusion_list(){
  exclusion_list=("tmux" "other")
  for excluded_item in "${exclusion_list[@]}"; do
    if [[ "$excluded_item" == "$1" ]]; then
      echo -e "${RED}[WARNING] Found ${1} in exclusion list.${NC}"
      return 0
    fi
  done
  return 1
}

validate_if_dirs_exist() {
  local pwd_dirs
  walk_dir_names pwd_dirs

  local -n valid_directory_list=$1
  valid_directory_list=()

  for dir in "${pwd_dirs[@]}";do
    if !(dir_in_exclusion_list $dir) && dir_exists $dir; then
      valid_directory_list+=("${dir%/}")
    fi
  done
}

#softlinks dirs from current dir to ${HOME}/.config
softlink_dirs() {
  local -n dirs=$1
  for dir in "${dirs[@]}"; do
    ln -sf ${PWD}/${dir} ${HOME}/.config
    echo -e "${GREEN}[SUCESS] Soft-linked ${dir} to ${HOME}/.config/${dir}${NC}"
  done 
}

main() {
  local valid_dirs
  validate_if_dirs_exist valid_dirs

  softlink_dirs valid_dirs

}
#create setup command
#create destroy command, add warning
#add --help 

main
