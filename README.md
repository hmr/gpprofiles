# **IMPORTANT NOTICE**
This repository has moved to GitHub(https://github.com/hmr/gpprofiles).
Choose A or B below to change your local repository's 'origin':
---
```
#A: read only access
git remote set-url origin https://github.com/hmr/gpprofiles.git

#B: read/write access(by ssh)
git remote set-url origin git@github.com:hmr/vim-cheat-sheet.git
```
---

# gpprofile(General Purpose Profiles for GNU Bash)
My version of unix profiles.

## How to use
Clone or update(pull) this repository and run 'install.sh'

## After installation advices

### Using Newer Vim
With using vim under this profile. You must install vim 8.0(+) or you should modify dot-vimrc file.

#### Installing Vim 8.1
With Old Ubuntu, use PPA as below:
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudp apt install vim-enhanced
```
#### Install vim plugins
Start vim and type as below:
```
:PlugInstall
```
Then the vimPlug will automagically install plugins!

## Problems?
https://bitbucket.org/wassha/gpprofiles/issues
