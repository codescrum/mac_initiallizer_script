#!/usr/bin/env bash

main(){
  # The first step is to install zsh.
  brew install zsh zsh-completions

  # Install zplug, the manager of plugins we will use.
  if [[ ! -d ~/.zplug ]]; then
    echo "zplug not found. Installing zplug..."
    curl -sL zplug.sh/installer | zsh
  fi

  # Update the zsh console manually to run zsh
  # First of all, add to the allowed shells
  insert_line_into_file_as_sudo $(which zsh) /etc/shells

  # if [[ ! -a ~/.zshrc ]]; then   # There will be a symlink after the installation process, and the file must not exist
  #   touch ~/.zshrc
  # fi

  # Set as default the ZSH console if is not already set
  if [[ $(echo $0) != '-zsh' ]]; then
    echo "ZSH is not the default console. Change it."
    chsh -s $(which zsh)
  fi
}

insert_line_into_file(){
  line=$1
  file=$2
  grep -q "$line" "$file" || echo "$line" >> "$file"
}
insert_line_into_file_as_sudo(){
  # Be careful, this command can mess with the permissions of the files
  line=$1
  file=$2
  if [ -z $(grep "$line" "$file") ]; then
    sudo sh -c "echo "$line" >> "$file""
  fi
}

main "$@"
