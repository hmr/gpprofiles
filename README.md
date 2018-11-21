# unix_profiles_hmr
My version of unix profiles.

## How to use
Copy and paste below.
```
cat << __EOF__ > inst_gpprofiles.sh && bash ./inst_gpprofiles.sh; rm -f inst_gpprofiles.sh
#! /bin/bash
cd ~ &&\
rm -rf unix_profiles_hmr &&\
mkdir -p src &&\
git clone git@bitbucket.org:wassha/gpprofiles.git src/gpprofiles &&\
src/gpprofiles/install.sh &&\
rm -rf unix_profiles_hmr
__EOF__
```

## After installation

### Using Vim
With using vim under this profile. You must install vim 8.0(+) or you should modify dot-vimrc file.

#### Installing Vim8.1
With Ubuntu, use PPA as below:
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
vimPlug will install plugins auto-magically.

## Problems?
https://github.com/hmr/unix_profiles_hmr/issues
