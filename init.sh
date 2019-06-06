#!/usr/bin/env bash

# Created by Sebastián Landínez, based on https://github.com/gato-omega/my-dots
set -eu   # Make that the errors in every script stop the execution of the general script.

PWD=$(pwd)

source $PWD/lib/modules/avoidDoubleImport.sh

echo ""
echo "------------------------------"
echo "Set etc/hosts configurations."
echo "------------------------------"
echo ""
sh scripts/set_hosts.sh

echo ""
echo "------------------------------"
echo "Install brew and some other required installers (core-utils also for the realpath, etc.)"
echo "------------------------------"
echo ""
sh scripts/binaries.sh

echo ""
echo "------------------------------"
echo "Install some apps through Brew. This includes chrome, skype, atom, etc."
echo "------------------------------"
echo "" 
sh scripts/apps.sh

# Put some defaults related to the environment
export dirname=$(dirname $(realpath $0))
export lib="$dirname/lib"
export SHELL_LIBRARY_PATH="$dirname/lib"

# I think the first should be install ZSH and the plugin managers, in this case, we'll use
# zPlug, can be found in: https://github.com/zplug/zplug

echo ""
echo "------------------------------"
echo "Install ZSH and the plugin manager zPlug."
echo "------------------------------"
echo ""
sh scripts/install_zsh.sh

echo ""
echo "------------------------------"
echo "Add the ssh-key to the system"
echo "------------------------------"
echo ""
read -p "Do you want to create a SSH key for this PC? [y/n] " confirmation
case $confirmation in
  [Yy]* )
    sh scripts/ssh_add.sh
    ;;
esac

echo ""
echo "------------------------------"
echo "Setting the Ruby environment and other development tools."
echo "------------------------------"
echo ""
# Check first if git is installed, it's a requirement for the following installations.
if [[ ! $(which git) ]]; then
  echo "Git is not installed. It is not possible to install Rbenv, nodenv, and other package managers"
else
  sh scripts/rbenv.sh
  sh scripts/jenv.sh
  sh scripts/nodenv.sh
  sh scripts/phantomenv.sh
fi

echo ""
echo "------------------------------"
echo "Create the dotfiles directory and run the necessary tasks"
echo "------------------------------"
echo ""
zsh scripts/dotfiles_configuration.sh

echo ""
echo "------------------------------"
echo "Setting some security components."
echo "------------------------------"
echo ""
sh scripts/security.sh

echo ""
echo "------------------------------"
echo "Setting sensible OSX defaults."
echo "------------------------------"
echo ""
sudo sh scripts/defaults.sh

# Pgsql info
echo
echo "########################################################"
echo "Please install Postgres app from https://postgresapp.com"
echo "########################################################"
echo

echo "------------------------------"
echo "Completed the init configuration for your mac 😎."
echo "Restart your computer to ensure all updates take effect"
echo "------------------------------"
