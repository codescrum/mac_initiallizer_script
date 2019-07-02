#!/usr/bin/env bash
set -eu

# Application installer (via brew-cask)

# Apps
apps=(
  alfred               # Alfred
  dropbox              # Dropbox
  google-chrome        # Google Chrome browser
  google-chrome-canary # Google Chrome Canary

  #### Quicklook Enhancements End

  slack                # Slack(#)
  firefox              # Firefox browser
  # virtualbox
  vagrant              # Vagrant
  iterm2               # iTerm2 terminal replacement app
  sublime-text        # Sublime Text
  vagrant              # Vagrant https://www.vagrantup.com/
  vagrant-manager      # Vagrant manager https://github.com/lanayotech/vagrant-manager
  ngrok                # https://ngrok.com/ and https://ngrok.com/product # Another option: http://www.ultrahook.com/ | Version 2.0 is only available as a cask -> https://github.com/Homebrew/homebrew/issues/39573
  atom                 # Atom text/code editor
  flux                 # Human friendly screen luminosity https://justgetflux.com/
  visual-studio-code   # visual studio code, other IDE like atom or sublime-text
  vlc                 # VLC (Video Lan Player)
  skype               # Skype
  imageoptim         # Lossless in-place image compression https://imageoptim.com/
  spectacle          # Keyboard shortcuts for window management https://github.com/eczarny/spectacle
  screenflow          # Video editing software http://telestream.net/screenflow/overview.htm
  gimp               # GIMP, Image editing software
  docker             # Docker for mac
)

fonts=(
 font-roboto
 font-inconsolata
)

atom=(
  css-comb                      # Auto adjusts CSS files. Shortcut: Ctrl Alt C
  git-diff                    # Shows in Atom which lines have been added, edited or modified. Already included in the bundle
  git-history                   # Shows the different versions of a file
  markdown-preview            # Markdown preview (for Readme.md, for example). Activate with ctrl+shift+m. Bundled with atom
  npm-install                   # Automatically installs and save Node packages not already included
  zentabs                       # Set a maximum of opened tabs
  autocomplete-modules          # Autocomplete whenever there's a require clause
  color-picker                  # Displays a color picker in atom
  docblockr                     # Helps the creation of documentation
  file-icons                    # Adds icons depending on the type of the file
  highlight-line                # Highlights the current line.
  highlight-selected            # Double clicking a word will highlight it in all the file
  language-babel                # Language grammar for ESX2016 and JSX
  language-haml                 # Language grammar for HAML
  linter                        # In-situ debugging of errors
  merge-conflicts               # Visualization for the merge conflicts
  pigments                      # Colors the RGB in code
)

# Specify the location of the apps
# appdir="/Applications" # this seems to be the default? # we will see

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

main() {

  # Ensure homebrew is installed
  homebrew

  # Install homebrew-cask
  echo "installing cask-versions..."
  brew tap homebrew/cask-versions

  # Tap the fonts
  echo "installing cask-fonts..."
  brew tap homebrew/cask-fonts
  set +e
  set -e


  # install apps
  echo "installing apps with brew cask..."
  brew cask install ${apps[@]}
  # brew cask reinstall --appdir=$appdir ${apps[@]} # do not install in /Applications
  # brew cask reinstall --appdir=$appdir ${apps[@]} # the reinstall subcommand exists?

  # restart quicklook manager for quicklook (ql) enhancements to take effect
  qlmanage -r

  # install fonts
  echo "installing fonts..."
  brew cask install ${fonts[@]}

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}
  cleanup
}

homebrew() {
  if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

alfred() {
  brew cask alfred link
}

cleanup() {
  brew cleanup
}

main "$@"
exit 0
