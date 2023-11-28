# gpprofile(General Purpose Profiles)
Generic user settings for Unix-like system.

## 
- [ ] Modify system configurations.
  - [ ] Make sudo work w/o authentication.
  - [ ] (macOS) NFS client setting.
- [ ] (macOS) Install Xcode.
- [ ] (macOS) Set up Homebrew.
- [ ] (macOS) Install homebrew's packages.
- [x] Install zsh and bash start up scripts.
- [ ] Generate SSH key-pair(s) and set it into authrized_keys file.
- [ ] Install configuration files for various applications.
  - [ ] alsa
  - [ ] ansible
  - [ ] bat
  - [ ] cspell
  - [ ] dircolors
  - [ ] git
  - [ ] homebrew
  - [ ] htop
  - [ ] istats-meny
  - [ ] iterm2
  - [ ] jenv
  - [ ] karabiner
  - [ ] kitty
  - [ ] less
  - [ ] lsd
  - [ ] mozilla
  - [ ] quilt
  - [ ] readline
  - [ ] ripgrep
  - [ ] tmux
  - [ ] vim

## How to use
Clone this repository and execute 'setup.sh'

```console
$ git clone --recursive git@github.com:hmr/gpprofiles.git -b v2-dev
.....
.....
$ cd gpprofiles
$ ./setup.sh
```

## After setup script works

### Install zsh plugins
```
$ zplug install
```

### Install Vim plugins
Start vim and type as below:
```
:PlugUpgrade
:PlugClean!
:PlugInstall!
```
vim-plug will automatically install plugins.

### Install tmux plgins
Start tmux then push Ctrl+Space Shift+I.

## Problems?
https://github.com/hmr/gpprofiles/issues

