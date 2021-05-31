#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    update_srcs.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lorenuar <lorenuar@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/18 21:52:27 by lorenuar          #+#    #+#              #
#    Updated: 2020/04/18 21:52:27 by lorenuar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GR='\033[32;1m'										#	Green
RE='\033[31;1m'										#	Red
WI='\033[33;1m'										#	Yellow
CY='\033[36;1m'										#	Cyan
RC='\033[0m'										#	Reset Colors

file='Makefile'										#	Makefile name
bkpfile='.'$file'.bkp.in.case.something.goes.wrong' # 	Backup file name

SRCname='SRCS'										#	Pattern to look for
SRCdir='src'										#	Srcs directory name
SRCfindptrn="**.c"									#	Find pattern

HEADERname='HEADERS'								#	Pattern to look for
HEADERdir='includes'								#	Headers directory name
HEADERfindptrn="**.h"								#	Find pattern



SRC_MARK_START="###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼"
SRC_MARK_END="###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲"
#	Marker for updating without messing up the file

splitA=.split.a.ignore.me
splitB=.split.b.ignore.me

function check_file()
{
	if [ -r $file ]; then
		printf $GR$file" is a readable file"$RC" > "
		cp $file $bkpfile
	else
		printf $RE"Error : "$file" is not a readable file"$RC'\n'
		return 1
	fi

	return 0
}

function get_split()
{
	split_at=$(grep -n -m 1 $SRC_MARK_START $file | sed 's/:.*//')
	check_end_mark=$(grep -n -m 1 $SRC_MARK_END $file | sed 's/:.*//')
	if [[ ! -z $split_at ]] && [[ -z $check_end_mark ]]
	then
		printf $RE"Cannot find $SRC_MARK_END in $file"$RC"\n"
		exit 1
	fi
	if [ -z $split_at ]
	then
		split_at=$(grep -n -m 1 $SRCname $file | sed 's/:.*//')
		printf $CY"Found '$SRCname' at line $split_at"$RC" > "
	else
		printf $CY"Found '$SRC_MARK_START' at line $split_at"$RC" > "
		OLD_FOUND=1
	fi
	return 0
}

function split_append_join()
{
	rm -fv $splitA $splitB

	if [ $OLD_FOUND == 1 ]; then
		sed_string="/^${SRC_MARK_START}$/,/^${SRC_MARK_END}$/p"
		rem_old=$(sed -n $sed_string $file | wc -l)

		split_start=$(($split_at - 1))
		split_end=$(($split_at + $rem_old +_1))
		head -n $split_start $file > $splitA
		tail -n +$split_end $file > $splitB
		printf $CY$file" split & removed from line "$split_start" to "$split_end" \
("$rem_old") into "$splitA" & "$splitB$RC"\n"
	else

		head -n $(($split_at - 1)) $file > $splitA
		tail -n +$(($split_at + 1)) $file > $splitB
		printf $CY$file" split at line "$split_at" into "$splitA" & "$splitB$RC"\n"
	fi

	echo $SRC_MARK_START >> $splitA
	echo "# **************************************************************************** #" >> $splitA
	echo "# **   Generated with https://github.com/lorenuars19/makefile-src-updater   ** #" >> $splitA
	echo "# **************************************************************************** #" >> $splitA
	echo "" >> $splitA
	echo $SRCname" = \\" >> $splitA

	if [[ -d $SRCdir ]]
	then
		find ./$SRCdir -type f -name "$SRCfindptrn" | sed -e 's|^|	|'| sed -e 's|$| \\|' >> $splitA
		printf $CY"$SRCname appended to "$splitA$RC"\n"
	fi

	echo "" >> $splitA
	echo $HEADERname" = \\" >> $splitA

	if [[ -d $HEADERdir ]]
	then
		find ./$HEADERdir -type f -name "$HEADERfindptrn" | sed -e 's|^|	|'| sed -e 's|$|\\|' >> $splitA
		printf $CY"$HEADERname appended to "$splitA$RC"\n"
	fi

	echo "" >> $splitA
	echo $SRC_MARK_END >> $splitA
	cat $splitA $splitB > $file
	printf $GR"$file re-joined"$RC"\n"

	return 0
}

OLD_FOUND=0

check_file
if [ $? == 1 ];then
	exit 1
fi

get_split

if [[ OLD_FOUND -eq 0 ]]; then
	printf $RE"Do you want to continue (Y/n)? "$RC
	read ans
	if [ "$ans" == "Y" ] || [ "$ans" == "y" ] || [ -z "$ans" ];then
		split_append_join $split_at
		rm -fv $splitA $splitB
	else
		exit 0
	fi
else
	split_append_join $split_at
	rm -fv $splitA $splitB
fi
