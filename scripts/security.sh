#!/usr/bin/env bash

###############################################################################
# Security settings, see https://github.com/drduh/OS-X-Yosemite-Security-and-Privacy-Guide
###############################################################################

# from https://github.com/kfinlay/dots/commit/d6d71e257f1313d5fb7e62d4448935db65191f44
set -eu
echo "security"

# if already enabled no worries
set +e
# Enabling FileVault 2
# Only with iCloud account, if you run this command without one iCloud account the system won't boot once you restart or shutdown it.
# sudo fdesetup enable
set -e

echo "Enabling Application Level Firewall..."

# Enabling Firewall by default
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsigned off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setallowsignedapp off
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setloggingmode on
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setstealthmode on


