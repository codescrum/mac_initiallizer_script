#!/usr/bin/env zsh
main(){
  # Install Jenv for managing the Java versions
  # First of all, check if Git is installed
  if [[ ! $(which git) ]]; then
    echo "Git is not installed."
    return
  fi
  ########################### JENV INSTALLATION ###########################
  # Check if jenv is installed
  if [ -z $(which jenv) ]; then
    # Install jenv
    git clone https://github.com/gcuisinier/jenv.git ~/.jenv    
  fi
}
main "$@"
