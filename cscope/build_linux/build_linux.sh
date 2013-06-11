#!/bin/bash
DIR_LINUX=/usr/src/kernels/linux/
CSCOPE_FILES=./cscope.files
CSCOPE_DB=./cscope.out
find $DIR_LINUX -path $DIR_LINUX/arch ! -path $DIR_LINUX/arch/x86 -prune -o -path $DIR_LINUX/include/asm-generic -prune -o -path $DIR_LINUX/samples/ -prune -o -path $DIR_LINUX/scripts -prune -o -path $DIR_LINUX/drivers/ -prune -o -name "*.[chxsS]" -print > $CSCOPE_FILES
cscope -bqkR -i $CSCOPE_FILES

