# makefile-scrs-updater
You are a 42 network student and you are tired of typing your srcs manually ? This script will do it for you
# Usage 
1. Copy the script into a folder containing a Makefile
2. run the script
# Warning
**DO NOT REMOVE THE BACKUP FILE UNLESS YOU ARE SURE THAT YOU DON'T NEED IT ANYMORE, THIS SCRIPT *REPLACES* THE CONTENT OF YOUR FILE**<br>
I decline all responsibilities in case of any lose of any content.
# Customization
You can tweak and change the name of the files and the pattern to grep
```
file='Makefile'		#	Makefile name
bkpfile='.'$file'.bkp.in.case.something.goes.wrong' # Backup file name
srcname='SRCS'		#	Pattern to look for
srcdir='src'		#	Srcs directory name
findptrn='*.c'		#	Find pattern

splitA=.split.a.ignore.me
splitB=.split.b.ignore.me
```
