#!/usr/bin/env zsh
main()
{
  # First of all, move all the templates in this script to a directory called dotfiles
  mkdir ~/dotfiles
  cp $script_exec_dir/../templates/.[^.]* ~/dotfiles     # Copy the contents to the newly created directory
  cd ~/dotfiles           # Initiallize a git repo in this directory
  git init
  # As stated in this guide (https://codingkilledthecat.wordpress.com/2012/08/08/git-dotfiles-and-hardlinks/),
  # it's better to link the files from inside the repo outside of it.
  cd ~
  # Do a symlink between every file in the dotfiles directory and the home directory
  for f in ~/dotfiles/.[^.]*
  do
    # Create a symlink between this file and the file in the HOME directory
    ln -s $f ~/$(basename $f)
  done
  # For some reason, a git repo is created at ~ directory. Remove it:
  rm ~/.git
  source ~/.zshrc
  source ~/.gemrc
  # Some files created are created without permissions required. Add this line to modify this permissions
  compaudit | xargs chmod g-w

  # Node build installation, for using the command nodenv install
  git clone https://github.com/nodenv/node-build.git $(nodenv root)/plugins/node-build
}

script_exec_dir=$(dirname $0)
main "$@"
