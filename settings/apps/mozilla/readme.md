# README for mozilla

## What's this

In this directory you will find a userChrome file that eliminates the tab display at the top of the window and the title from the tree-style tabs in the sidebar. 

## How to install

1. Open about:config and set 'toolkit.legacyUserProfileCustomizations.stylesheets' to true.
1. Grasp current profile directory from about:profiles.
1. Create a link in the profile directory by `ln -s $GPP_HOME/settings/mozilla/chrome /path/to/mozilla/profile/`

