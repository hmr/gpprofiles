#!/bin/bash


SRCDIR=`pwd`

SRCS=".inputrc .vim .vimrc .bashrc_history .bashrc_alias .byobu"
DATE=`date +'%Y%M%d_%H%M%S'`


cd ~
for TARGET in ${SRCS}
do
    TARGETSRC=`echo ${TARGET} | sed -e 's/^\./dot-/'`
    echo
    echo Installing ${TARGET} from ${TARGETSRC}
    cd ~
    if [ -e ${TARGET} ]; then
        if [ -L ${TARGET} ]; then
	    # Delete Symlink
	    echo "    Deleting symbolic link ${TARGET}"
	    rm -f ${TARGET}
	else
	    # Move to backup
	    echo "    Backing up ${TARGET} as ${TARGET}.${DATE}"
	    mv ${TARGET} ${TARGET}.${DATE}
	fi
    fi

    # Make symlink
    echo "    Making symbolic link"
    ln -sf ${SRCDIR}/${TARGETSRC} ${TARGET}
done

echo Adding to bashrc
grep .bashrc_history .bashrc >& /dev/null
if [ $? -ne 0 ]; then
    echo "    Installing bashrc_history"
    echo "source .bashrc_history" >> .bashrc
else
    echo "    bashrc_history is already installed."
fi

grep .bashrc_alias .bashrc >& /dev/null
if [ $? -ne 0 ]; then
    echo "    Installing bashrc_alias"
    echo "source .bashrc_alias" >> .bashrc
else
    echo "    bashrc_alias is already installed."
fi

grep '#byobu-prompt#' .bashrc >& /dev/null
if [ $? -ne 0 ]; then
    echo "    Installing byobu-prompt"
    echo "[ -r /home/maruyama/.byobu/prompt ] && . /home/maruyama/.byobu/prompt   #byobu-prompt#" >> .bashrc
else
    echo "    byobu-prompt is already installed."
fi

