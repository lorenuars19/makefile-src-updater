#!/bin/bash

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    update_srcs.sh                                     :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lorenuar <lorenuar@student.s19.be>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/04/18 18:43:29 by lorenuar          #+#    #+#              #
#    Updated: 2020/04/18 21:25:54 by lorenuar         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

GR='\033[32;1m'     #	Green
RE='\033[31;1m'     #	Red
WI='\033[33;1m'     #	White
CY='\033[36;1m'     #	Cyan
RC='\033[0m'        #   Reset Colors

file='Makefile'     #   Makefile name
bkpfile='.'$file'.bkp.in.case.something.goes.wrong' # Backup file name
srcname='SRCS'      #   Pattern to look for

splitA=split.a.ignore.me
splitB=split.b.ignore.me

if [ -r $file ]; then
    printf $GR$file" is a readable file"$RC" > "
    cp $file $bkpfile
else
    printf $RE"Error : "$file" is not a readable file"$RC'\n'
    exit 1
fi

split_at=$(grep -n -m 1 $srcname $file | sed 's/:.*//')
printf $CY"Found '$srcname' at line $split_at"$RC" > "

printf $WI"Do you want to proceed (Y/n)? "$RC
read ans
if [ "$ans" == "N" ] || [ "$ans" == "n" ] ;then
    exit 0
fi



