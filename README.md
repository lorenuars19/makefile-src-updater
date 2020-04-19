# makefile-scrs-updater
You are a 42 network student and you are tired of typing your srcs manually ? This script will do it for you
# Usage 
1. Copy the script into a folder containing a Makefile with a line containing `$srcname`
2. run the script (it is interactive)
# Warning
**DO NOT REMOVE THE BACKUP FILE UNLESS YOU ARE SURE THAT YOU DON'T NEED IT ANYMORE, THIS SCRIPT *REPLACES* THE CONTENT OF YOUR FILE**<br>
I decline all responsibilities in case of any lose of any content.
# Customization
You can tweak and change the name of the files and the pattern to grep
```
file='Makefile'										                  #	Makefile name
bkpfile='.'$file'.bkp.in.case.something.goes.wrong' # 	Backup file name
srcname='SRCS'										                  #	Pattern to look for
srcdir='src/'										                    #	Srcs directory name
findptrn='( -name '*.c' )'							            #	Find pattern

SRC_MARK_START="###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼"
SRC_MARK_END="###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲"
#	Marker for updating without messing up the file

splitA=.split.a.ignore.me
splitB=.split.b.ignore.me
```
# How it works
1. Find the line containing the `$srcname` with `grep`
2. Split the file into two files `$splitA` & `$splitB`
3. Append the content to `$splitA`
4. Re-join the two splits
# Contribute
I am far form an expert in shell scripting, there's likely better ways to implement it.
So feel free to pull request, to upgrade and improve this script.
