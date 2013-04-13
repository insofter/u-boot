#!/bin/sh

if ! git status | grep  -q "nothing to commit"
then
  echo Commit u-boot!
  exit 1
fi


mv include/configs/icdtcp3.h include/configs/icdtcp3.h.old


SEARCH='#define CONFIG_BOOTCOMMAND "tftp $loadaddr flash-script.img; source $loadaddr"'
REPLACE='#define CONFIG_BOOTCOMMAND "env set bootcmd '"\'"'tftp $loadaddr flash-script.img; source $loadaddr'"\'"'; env save; reset"'

cat include/configs/icdtcp3.h.old | sed "s/$SEARCH/$REPLACE/g" > include/configs/icdtcp3.h


make ARCH=arm CROSS_COMPILE=arm-linux- icdtcp3 && mv u-boot.bin icdtcp3-reset.bin


mv include/configs/icdtcp3.h.old include/configs/icdtcp3.h




