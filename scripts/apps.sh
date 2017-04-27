#!/usr/bin/env bash
set -eu

#
# Application installer (via brew-cask)
#

# Apps
# We will use Atom from now on, comment sublime, uncomment atom
apps=(
  # shimo                # VPN client http://www.feingeist.io/shimo/
  # 1password            # password manager https://agilebits.com/onepassword
  alfred               # Alfred
  dropbox              # Dropbox
  google-chrome        # Google Chrome browser
  google-chrome-canary # Google Chrome Canary

  #### Quicklook Enhancements Begin

  # qlcolorcode
  # qlstephen
  # qlmarkdown
  # quicklook-json
  # qlprettypatch
  # quicklook-csv
  # betterzipql
  # webpquicklook
  # suspicious-package

  #### Quicklook Enhancements End

  # gmail
  # screenflick          # Video/desktop recording software http://www.araelium.com/screenflick
  slack                # Slack(#)
  # transmit             # SFTP client and more https://panic.com/transmit/
  # appcleaner           # Cleans files and apps http://www.macupdate.com/app/mac/25276/appcleaner
  firefox              # Firefox browser
  # hazel                # Automatic filing https://www.noodlesoft.com/hazel.php
  # seil                 # Change CAPS-LOCK key (e.g. to ESC), https://github.com/tekezo/Seil
  # karabiner            # Keyboard mappings customizer https://github.com/tekezo/Karabiner
  # spotify
  vagrant              # Vagrant
  # arq                  # Backup tool https://www.arqbackup.com/
  # flash                # Adobe Flash https://github.com/caskroom/homebrew-cask/blob/master/Casks/flash.rb
  iterm2               # iTerm2 terminal replacement app
  # shiori               # Pinboard and Delicious OS X client http://aki-null.net/shiori/
  # sublime-text         # Sublime Text
  sublime-text2        # Sublime Text 2
  virtualbox           # Virtualbox
  vagrant              # Vagrant https://www.vagrantup.com/
  vagrant-manager      # Vagrant manager https://github.com/lanayotech/vagrant-manager
  ngrok                # https://ngrok.com/ and https://ngrok.com/product # Another option: http://www.ultrahook.com/ | Version 2.0 is only available as a cask -> https://github.com/Homebrew/homebrew/issues/39573
  atom                 # Atom text/code editor
  flux                 # Human friendly screen luminosity https://justgetflux.com/
  # mailbox
  # sketch              # Digital design app, http://www.sketchapp.com/
  # tower               # git client http://www.git-tower.com
  vlc                 # VLC (Video Lan Player)
  # cloudup             # Share stuff https://cloudup.com
  # nvalt               # Some app to write quicker http://brettterpstra.com/projects/nvalt/
  skype               # Skype
  # transmission        # BitTorrent Client http://www.transmissionbt.com/
  # cyberduck           # Libre FTP, SFTP, WebDAV, S3, Azure & OpenStack Swift browser https://cyberduck.io/
  # quicksilver        # Progressive autolearning shortcuts for OS X http://qsapp.com/
  imageoptim         # Lossless in-place image compression https://imageoptim.com/
  # sequel-pro          # MySQL management app http://www.sequelpro.com/
  spectacle          # Keyboard shortcuts for window management https://github.com/eczarny/spectacle
  screenflow          # Video editing software http://telestream.net/screenflow/overview.htm
  gimp               # GIMP, Image editing software
  # rescuetime       # Rescue Time https://www.rescuetime.com
  docker             # Docker for mac
)

# fonts
fonts=(
 # font-sauce-code-powerline
 # font-m-plus
 # font-clear-sans
 font-roboto
 font-inconsolata
)

# Atom packages # - not using atom right now
atom=(
  # Not included in the doc
  # advanced-railscasts-syntax  # Didn't find any info
  # atom-beautify               # Automatically indents files.
  # cmd-9                       # Make that the key combination cmd+9 takes you to the last tab, not the ninth.
  css-comb                      # Auto adjusts CSS files. Shortcut: Ctrl Alt C
  # easy-motion                 # Quickly navigate among words in the same line
  # editor-stats                # Display statistics about keyboard and mouse usage
  # fancy-new-file              # Allows to create a file inside a folder directly. Unavailable for atom 1.10
  git-diff                    # Shows in Atom which lines have been added, edited or modified. Already included in the bundle
  git-history                   # Shows the different versions of a file
  # image-view                  # Displays images in the editor. Bundled with atom.
  # inc-dec-value               # Increases, decreases a number, capitalizes, lowercases strings with the alt+up, alt+down shortcut
  # key-peek                    # Keybinding resolving
  # language-jade               # Language grammar for Jade programming
  markdown-preview            # Markdown preview (for Readme.md, for example). Activate with ctrl+shift+m. Bundled with atom
  # neutron-ui                  # No info found
  npm-install                   # Automatically installs and save Node packages not already included
  # react                       # React.js syntax support. Incompatible with language-babel
  # vim-mode                    # Vim modal control for Atom
  zentabs                       # Set a maximum of opened tabs
  # Included in the doc
  autocomplete-modules          # Autocomplete whenever there's a require clause
  color-picker                  # Displays a color picker in atom
  docblockr                     # Helps the creation of documentation
  # emmet                         # Quick coding for HTML
  file-icons                    # Adds icons depending on the type of the file
  highlight-line                # Highlights the current line.
  highlight-selected            # Double clicking a word will highlight it in all the file
  language-babel                # Language grammar for ESX2016 and JSX
  language-haml                 # Language grammar for HAML
  linter                        # In-situ debugging of errors
  merge-conflicts               # Visualization for the merge conflicts
  pigments                      # Colors the RGB in code
  # git-time-machine            # Shows a visual representation of the dates when the commits are made
  # git-plus                    # Allows to commit, add, etc. from Atom, without shell
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
  echo "installing cask..."
  # brew tap phinze/homebrew-cask # old commands?
  # brew reinstall brew-cask      # old commands?

  # Tap alternative versions https://github.com/caskroom/homebrew-versions
  # this lets you install previous versions of apps
  brew tap caskroom/versions

  # Tap the fonts
  brew tap caskroom/fonts
  # See https://github.com/caskroom/homebrew-cask, now it is installed as:
  set +e
  brew install caskroom/cask/brew-cask
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
  # install mackup
  # echo "installing mackup..."
  # pip install mackup

  # install atom plugins
  echo "installing atom plugins..."
  apm install ${atom[@]}
  # homebrew cask link with alfred
  # alfred  I can't find a reference to this command in the current documentation. Maybe it was deprecated
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
