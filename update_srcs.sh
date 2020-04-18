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

GR='\033[32;1m'		#	Green
RE='\033[31;1m'		#	Red
WI='\033[33;1m'		#	Yellow
CY='\033[36;1m'		#	Cyan
RC='\033[0m'		#	Reset Colors

file='Makefile'		#	Makefile name
bkpfile='.'$file'.bkp.in.case.something.goes.wrong' # Backup file name
srcname='SRCS'		#	Pattern to look for
srcdir='src'		#	Srcs directory name
findptrn='*.c'		#	Find pattern

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
	split_at=$(grep -n -m 1 $srcname $file | sed 's/:.*//')
	printf $CY"Found '$srcname' at line $split_at"$RC" > "
	
	return $split_at
}

function split_append_join()
{
	rm -f $splitA $splitB

	head -n $(($split_at - 1)) $file > $splitA
	tail -n +$(($split_at + 1)) $file > $splitB
	printf $CY$file" split at line "$split_at" into "$splitA" & "$splitB$RC"\n"

	echo "# ***************************************************************** #" >> $splitA
	echo "#     Generated with github.com/lorenuars19/makefile-scrs-updater   #" >> $splitA
	echo "# ***************************************************************** #" >> $splitA
	echo $srcname" =" >> $splitA
	find -name '*.c' | cut -c 3- | sed -e 's|$| \\|' \
	| sed -e "s|^|\t|">> $splitA
	echo "" >> $splitA
	printf $CY"$srcname append to "$splitA$RC"\n"
	cat $splitA $splitB > $file
	printf $GR"$file re-joined"$RC"\n"
	return 0
}

check_file
if [ $? == 1 ];then
	exit 1
fi

get_split

printf $RE"Do you want to continue (Y/n)? "$RC
read ans
if [ "$ans" == "Y" ] || [ "$ans" == "y" ] || [ -z "$ans" ];then
	split_append_join $split_at
	rm -f $splitA $splitB
else
	exit 0
fi

printf $RE"Do you want to remove backup file (N/y)? "$RC
read ans
if [ "$ans" == "Y" ] || [ "$ans" == "y" ] ;then
	printf $RE
	rm -v $bkpfile
	printf $RC
else
	exit 0
fi

