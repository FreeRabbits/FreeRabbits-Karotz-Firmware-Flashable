#!/bin/bash

. /karotz/scripts/update_functions.sh

# Detects any crashed installation

if [ -e /usr/.install_yaffs_start ] && [ -e /usr/.install_yaffs_stop ]; then
    # Yaffs successfully installed
    logger -s "[INIT] clean yaffs found"
    #rm /usr/.install_yaffs_start
    #rm /usr/.install_yaffs_stop

elif [ -e /usr/.install_yaffs_start ] && [ ! -e /usr/.install_yaffs_stop ]; then
    # Yaffs has crashed
    logger -s "[INIT] yaffs crashed -> restore"
    restauration_yaffs
    reboot

elif [ ! -e /usr/.install_yaffs_start ] && [ -e /usr/.install_yaffs_stop ]; then
    # Something is wrong
    logger -s "[INIT] yaffs wrong -> restore"
    restauration_yaffs
    reboot
fi

if [ -e /usr/yaffs.tar.gz ]; then
    # Karotz has crashed during downloading
    rm /usr/yaffs.tar.gz
fi

FILES=$(ls -l /usr | grep -v lost+found | grep -v etc | wc -l)
FILES=`expr $FILES - 1`

# Starting Yaffs
if [ -e /usr/yaffs_start.sh ] && [ $FILES -gt 1 ]; then
    logger -s "[INIT] yaffs start"
    /usr/yaffs_start.sh
else
    logger -s "[INIT] no yaffs_start -> restore"
    restauration_yaffs
    reboot
fi
