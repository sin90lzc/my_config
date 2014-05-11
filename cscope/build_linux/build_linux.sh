#!/bin/bash

#!/bin/bash

####################################################################################################
#
#Description:
#	生成linux的cscope数据库
#Sysnopsis:
#
#Options：
#
#History:
#
#
#									Author:tim
#									 Email:lzcgame@126.com	
#									    QQ:20170748
####################################################################################################


function help(){
	cat <<HERE_DOCUMENT

HERE_DOCUMENT
return 0
}

DIR_LINUX=/usr/src/kernels/linux
CSCOPE_FILES=./cscope.files
CSCOPE_DB=./cscope.out


while [ -n "$1" ] ; do
	case $1 in
		-h|--help)
			help
			shift
			;;
		-d|--dirlinux)
			shift
			[ -d $1 ] && DIR_LINUX=${1%\/};shift && continue
			echo "$1 is not exists or not a directory!" && exit 1
			;;
		-f|--file)
			shift
			mkdir -p `dirname $1`
			CSCOPE_DB=$1
			shift
			;;		
		*)
			shift
			;;
	esac
done


find ${DIR_LINUX}/ -regex "${DIR_LINUX}/arch/x86.*\.[chxsS]" -print -o \
 -regex "${DIR_LINUX}/arch.*" -o \
 -regex "${DIR_LINUX}/include/asm\-x86.*\.[chxsS]" -print -o \
 -regex "${DIR_LINUX}/include/asm\-.*" -o \
 -path ${DIR_LINUX}/include/asm\-generic -prune -o \
 -path ${DIR_LINUX}/samples -prune -o \
 -path ${DIR_LINUX}/drivers -prune -o \
 -path ${DIR_LINUX}/scripts -prune -o \
 -path ${DIR_LINUX}/Documentation -prune -o \
 -path ${DIR_LINUX}/\.git -prune -o \
 -name "*.[chxsS]" -print > $CSCOPE_FILES

cscope -bqkR -i $CSCOPE_FILES -f $CSCOPE_DB

rm -f $CSCOPE_FILES

exit 0
