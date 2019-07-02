#!/usr/bin/env bash

echo "Going to install binaries."
# This script aims to install some needed binaries
# First, install brew for installing new packages
if [ ! $(which brew) ]    # Check if is already installed
then
  echo "Installing brew..."
  $(which ruby) -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
echo "Updating homebrew"
brew update

# Upgrade any already-installed formulae.
brew upgrade

# The console threw a warning about Xcode CLI. Install it
xcode-select --install

set +e
echo "Installing coreutils, findutils, bash v4 and grep"

# Install GNU core utilities (those that come with OS X are outdated)
echo "Installing GNU coreutils"
brew install coreutils

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
echo "Installing findutils"
brew install findutils

# Install Bash 4
echo "Installing Bash"
brew install bash

# Install more recent versions of some OS X tools
echo "Installing grep"
brew install grep

# scripts that could come next.
brew install gnu-sed

set -e

# Install other useful binaries
binaries=(
  ack
  tree                # output directory and file structure in the console
  the_silver_searcher # 'ag' commandline tool (a better grep)
  git                 # git
  hub                 # git+hub (from Github)
  fasd                # Command-line productivity booster, offers quick access to files and directories, inspired by autojump, z and v, https://github.com/clvv/fasd
  jenv                # java version manager (rbenv for java) [javas must be manually added]
  qt                  # qt lib
  imagemagick         # watch out for graphicsmagick possible conflicts with executables, http://www.graphicsmagick.org/utilities.html
  pkgconfig           # or pkg-config? is an utility that reads metadata in order to correctly install components at compile time (gcc)
)

# Install the binaries
set +e # If already installed, non-zero status error is reported, skip that
echo "Installing brew binaries"
brew install ${binaries[@]}
set -e # revert back to errors aborting the entire script

# Installing DVM through cURL. It looks like brew recipe is not working well.
curl -sL https://howtowhale.github.io/dvm/downloads/latest/install.sh | sh
# Remove outdated versions from the cellar
brew cleanup

exit 0
