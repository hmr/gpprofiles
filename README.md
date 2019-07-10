# gpprofile(General Purpose Profiles for GNU Bash)
User profile shell scripts for Unix-like system.

# For users using with bitbucket repository.
---
```bash
#A: read only access
grep "https://github.com/hmr/gpprofiles.git" .git/config >& /dev/null; [ $? -eq 1 ] && git remote set-url origin https://github.com/hmr/gpprofiles.git && git pull

#B: read/write access(by ssh)
grep "git@github.com:hmr/gpprofiles.git" .git/config >& /dev/null; [ $? -eq 1 ] && git remote set-url origin git@github.com:hmr/gpprofiles.git && git pull
```
---

## How to use
Clone or update(pull) this repository and run 'install.sh'


## After installation advices

### Use newer Vim
Using vim with this profile. Use vim8.0(+) or you should modify dot-vimrc file.

#### Install Vim8.1

##### Ubuntu(<=16.04)
With Old Ubuntu, use PPA as below to install vim8.1:
```
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudp apt install vim-enhanced
```

### Install vim plugins
Start vim and type as below:
```
:PlugClean!
:PlugInstall!
```
Then vim-plug will automagically install/update/delete plugins!

## Problems?
https://github.com/hmr/gpprofiles/issues
