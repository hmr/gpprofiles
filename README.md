# unix_profiles_hmr
My version of unix profiles.

## How to use
```
cd ~ && \
git clone https://github.com/hmr/unix_profiles_hmr.git && \
ln -s unix_profiles_hmr/.vim* . && \
ln -s unix_profiles_hmr/.bashrc_history . && \
ln -s unix_profiles_hmr/.bashrc_alias . && \
ln -s unix_profiles_hmr/.inputrc . && \
source .bashrc_history && \
source .bashrc_alias . && \
echo source .bashrc_history >> .bashrc && \
echo source .bashrc_alias >> .bashrc && \
echo ----- Below is tail of bashrc. ----- && \
tail .bashrc && \
echo "------------------------------" && \
echo "DONE"
```
