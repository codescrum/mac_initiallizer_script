# Mac OS Booting Script
These collection of scripts will load automatically a bunch of binaries, applications,
programs and some utilities for setting a development environment based on Ruby.<br>
Try it by downloading this repository and after running the command.<br>
```bash
sh $DIR_OF_THE_REPOSITORY/init.sh
```
## Requirements
You must have an Apple ID and download XCode, application that includes most of the
tools a developer needs.

## Structure
The directory structure is as follows: <br>
* <b>init.sh</b>: The main script, execute multiple calls to other scripts contained in
the scripts folder.
* <b>scripts</b>: This folder contains all the executed scripts
* <b>templates</b>: This folder might contain a whole bunch of configuration dotfiles. Right now,
it has only a .zshrc template.

## How it works?
The main script, init.sh, executes one by one the scripts in the scripts folder, in the following
order:
* <b><i>defaults.sh</b></i>: This script changes some Mac defaults at a low
level in order to improve performance, visibility and usability. Refer to the script for wider information.

* <b>binaries.sh</b>: This script installs some tools like:
  * [brew](http://brew.sh/)
  * [imagemagick](http://www.imagemagick.org/script/index.php)
  * [fasd](https://github.com/clvv/fasd)
  * among others. The full list is contained in the script, in the binaries variable.


* <b>install_zsh.sh</b>: This script installs [zsh](http://www.zsh.org/), a UNIX shell, and
[zplug](https://github.com/zplug/zplug), a zsh plugin manager. It also changes the default terminal
shell to ZSH

* <b>ssh_add.sh</b>: This script creates a new SSH key in the ~/.ssh directory and automatically
adds it to the ssh-agent for the device to authenticate with it. It also prompts the public key
for adding it to a Github/Bitbucket account.

* <b>apps.sh</b>: This script installs multiple user applications, like Google Chrome, Skype,
Virtualbox, the Atom editor. The full list can be found in the script, as the apps variable.
It also installs some Atom Packages for increasing productivity. The full list of packages can
be found in the script as the variable atom.

* <b><i>security.sh</b></i> (Not yet implemented): Runs some configuration related
to the firewalls for security

* <b>rbenv.sh</b>: Install [rbenv](https://github.com/rbenv/rbenv) for managing the versions of Ruby.

* <b>nodenv.sh</b>: Install [nodenv](https://github.com/nodenv/nodenv) for managing the versions of Node.

* <b>jenv.sh</b>: Install [jenv](https://github.com/gcuisinier/jenv) for managing the versions of Java.

* <b>phantomenv.sh</b>: Install [phantomenv](https://github.com/boxen/phantomenv) for managing the versions of PhantomJS.

* <b>hosts.sh</b>: Set a hosts file for blocking malware, adware, and other irritants. This script take a hosts file copy from templates dir and put it into /etc/hosts path. For more info about this visit [StevenBlack hosts repository](https://github.com/StevenBlack/hosts).

* <b>dotfiles_configuration.sh</b>: This file is run with the zsh shell rather than the bash console. It copies the templates in the templates directory to a directory in the `$HOME` directory called dotfiles. In this directory, is created a git repository and the templates are symlinked to the actual configuration files. In this way, any change done to the files in the `~/dotfiles` directory will be reflected directly in the configuration files and will be also under control version.

## Contributors
[Miguel Diaz](https://github.com/gato-omega)

[Diego Alejandro Alvis Palencia](https://github.com/diegoalvis)

[Sebastián Felipe Landínez García](https://github.com/sflang1)
