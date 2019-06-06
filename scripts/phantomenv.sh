#!/usr/bin/env zsh
main(){
  # Install Phantomenv for managing the Phantomenv versions
  # First of all, check if Git is installed
  if [[ ! $(which git) ]]; then
    echo "Git is not installed."
    return
  fi
  ################################ PHANTOMENV INSTALLATION ############################
  # Check if phantomenv is installed
  if [ -z $(which phantomenv) ]; then
    # Install phantomenv
    git clone -b v0.0.10 https://github.com/boxen/phantomenv.git ~/.phantomenv
    export PATH="$HOME/.phantomenv/bin:$PATH"
    eval "$(phantomenv init -)"
  fi
}
main "$@"
