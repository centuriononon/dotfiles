#!/bin/bash

PROCESS=$(tput setaf 3)
SUCCESS=$(tput setaf 2)
ERROR=$(tput setaf 1)
_RESET=$(tput sgr0)

user="centurion"
user_dir="/home/$user"

workdir="$user_dir/root/dotfiles"
files="$workdir/files"

config_names=("polybar" "zsh" "sxhkd" "bspwm" "nvim" "picom" "alacritty" "zathura")

polybar_sources=("$user_dir/.config/polybar/")
zsh_sources=("$user_dir/.config/zsh/")
sxhkd_sources=("$user_dir/.config/sxhkd/")
bspwm_sources=("$user_dir/.config/bspwm/")
nvim_sources=("$user_dir/.config/nvim/")
picom_sources=("$user_dir/.config/picom/")
alacritty_sources=("$user_dir/.config/alacritty/")
zathura_sources=("$user_dir/.config/zathura/")

rm -r "$files"
mkdir "$files"
cd "$workdir"

echo "${PROCESS}Validating sources..."
for cfg_name in "${config_names[@]}"; do
  sources_var="${cfg_name}_sources"
  eval sources=\${$sources_var[@]}
  
  # Validating the sources
  for src in "${sources[@]}"; do
    if [[ ! -e "$src" ]]; then
      echo "${ERROR}Not existing source: $src"
      exit 1
    fi
    
    if [ ! -f "$src" ] && [ ! -d "$src" ]; then
      echo "${ERROR}Expected source to be file or directory: $src"
      exit 1
    fi

    if [ ! -r "$src" ]; then
      echo "${ERROR}No access to read source: $src" 
      exit 1
    fi
  done
done

echo "${SUCCESS}Validated sources successfuly!${_RESET}"

for cfg_name in "${config_names[@]}"; do
  echo "${PROCESS}Copying $cfg_name sources...${_RESET}" 
  
  sources_var="${cfg_name}_sources"
  eval sources=\${$sources_var[@]}
  sources_len=${#sources[@]}
  dir="$files/$cfg_name"
	
  mkdir "$dir"

  # Resourcing
  for src in "${sources[@]}"; do
    src_name=$(basename "$src")

    if [ "$sources_len" -eq 1 ] && [ "$cfg_name" == "$src_name" ] ; then
      cp -r "$src" "$dir"
    else
      cp -r "$src" "$dir/$src_name" 
    fi

    if [ $? -eq 1 ]; then
      echo "${ERROR}Failed to copy source: $src"
    else
      echo "${SUCCESS}Copied source: $src${_RESET}"
    fi
  done
done
