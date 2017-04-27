#!/usr/bin/env bash
# Script for creating a new SSH key, and add it to the ssh agent.
set -eu
version="0.0.1"

main(){
  # Do a While loop through all the flags sent to the command
  # While the number of params is greater than 0 do the following block
  email=''
  name=''
  while [  $# -gt 0 ]; do
    case "$1" in
      -v|--version)
        echo "Version: $version"
        exit
        ;;
      -h|--help)
        usage
        exit
        ;;
      -e|--email)
        email="$2"
        ;;
      -n|--name)
        name="$2"
        ;;
    esac
    shift
  done
  create_ssh "$email" "$name"
}

usage(){
  # Outputs the help text
  cat <<EOF
  Script for creating a new SSH key and adding it to ssh agent.
  Usage:
  ssh-setup [-h|-v] [-e|-n]

  Options:
    --help, -h          Get this message
    --version, -v       Get the bash script version
    --email, -e         Introduce the email related to the SSH key created.
    --name, -n          Introduce the name of the key created. Defaults to id_rsa
EOF
}

create_ssh(){
  email=$1
  name=$2
  # Check if the email is null. If it is, ask for it in a prompt
  if [ -z "$email" ]
  then
    read -p "Please, introduce an email for the ssh key that will be created: " email
    if [ -z "$email" ]
    then
      # user didn't introduce an email. Maybe later a regex validation could be done here
      echo "You didn't introduce any value"
      return
    fi
    read -p "Please, introduce a hostname for the ssh key that will be created: " hostname
    if [ -z "$hostname" ]
    then
      # user didn't introduce an email. Maybe later a regex validation could be done here
      echo "You didn't introduce any value"
      return
    fi
  fi
  # Prompt that the key will be created by default to the id_rsa file
  if [ -z "$name" ]
  then
    echo "You have not introduced any filename for the key. It will be set by default to id_rsa"
    name="id_rsa"
  fi
  # Create the key with the params introduced
  # Set up the -C param in the format email+hostname@gmail.com
  # Extract the first part of the email. This weird syntax is needed for getting the position of a character
  position=$(echo $email | sed -n "s/[@].*//p" | wc -c)
  # Divide the string
  email_address=${email:0:(position-1)}
  domain_name=${email:position}
  ssh-keygen -t rsa -b 4096 -C "$email_address+$hostname@$domain_name" -f $name
  if [[ $(eval "$(ssh-agent -s)") == "Agent pid"* ]]; then
    # All the ssh keys will be stored in the directory ~/.ssh. Move the key to this directory
    # First of all, check that the ssh directory is created
    if [[ ! -d ~/.ssh ]]; then
      mkdir ~/.ssh
    fi
    # First check if the key is already there. If it is, ask for overwrite permission
    if [ -a ~/.ssh/$name ]
    then
      read -p "There is already a key with the name: $name. Do you wish to overwrite it? [y/n] " confirmation
      case $confirmation in
        [Yy]* )
          rm -rf ~/.ssh/$name*
          ;;
        [Nn]* )
          echo "The key will remain as it is."
          return
          ;;
      esac
    fi
    mv ./$name* ~/.ssh
    echo "You will be prompted to introduce the password you just added to your SSH key"
    ssh-add ~/.ssh/$name
    echo "Please, add this key to your Github/Bitbucket/other account"
    echo "$(cat ~/.ssh/$name.pub)"
  else
    echo "SSH Agent is not running. You'll have to turn it on and after add the key."
  fi
}

# Call function main
main "$@"
