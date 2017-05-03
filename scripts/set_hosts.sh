#!/usr/bin/env zsh
main(){
  sudo cp $script_exec_dir/../templates/hosts /etc/hosts
}
script_exec_dir=$(dirname $0)
main "$@"
