# gpprofile(General Purpose Profiles for GNU Bash)
User profile shell scripts for Unix-like system.

## How to use
Clone or update(pull) this repository and run 'install.sh'

## After installation advices

### Use newer Vim
Vim8.0 or newer is required.

#### How to install Vim8.0 or newer

##### Ubuntu(<=16.04)
With Old Ubuntu, use PPA to install vim8.1:
```bash
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudp apt install vim-enhanced
```

### Install Vim's plugins
Start vim and type as below:
```
:PlugUpgrade
:PlugClean!
:PlugInstall!
```
im-plug will automagically install/update/delete plugins.

## Problems?
https://github.com/hmr/gpprofiles/issues

### For users cloned from "bitbucket.org"
Please change upstream as described below:

---
```bash
#A: read only access
grep "https://github.com/hmr/gpprofiles.git" .git/config >& /dev/null; [ $? -eq 1 ] && git remote set-url origin https://github.com/hmr/gpprofiles.git && git pull

#B: read/write access(by ssh)
grep "git@github.com:hmr/gpprofiles.git" .git/config >& /dev/null; [ $? -eq 1 ] && git remote set-url origin git@github.com:hmr/gpprofiles.git && git pull
```
---


