# makefile-src-updater
You are a 42 network student and you are tired of typing your srcs manually ? This script will do it for you
# Usage
1. curl the script into a folder containing a Makefile with a line containing `$srcname`
```bash
curl https://raw.githubusercontent.com/lorenuars19/makefile-src-updater/master/update_srcs.sh -o update_srcs.sh && chmod 775 update_srcs.sh
```
2. curl this premade makefile
```bash
curl https://raw.githubusercontent.com/lorenuars19/makefile-template/master/Makefile -o Makefile
```
3. run the script (it is interactive)
# Warning
**DO NOT REMOVE THE BACKUP FILE UNLESS YOU ARE SURE THAT YOU DON'T NEED IT ANYMORE, THIS SCRIPT *REPLACES* THE CONTENT OF YOUR FILE**<br>
I decline all responsibilities in case of any lose of any content.
# Customization
You can tweak and change the name of the files and the pattern to grep
```
file='Makefile'         # Makefile name
bkpfile='.'$file'.bkp.in.case.something.goes.wrong'
# Backup file name

SRCname='SRCS'          # Pattern to look for
SRCdir='src/'           # Srcs directory name
SRCfindptrn="**.c"      # Find pattern

HEADERname='HEADERS'    # Pattern to look for
HEADERdir='includes/'   # Srcs directory name
HEADERfindptrn="**.h"   # Find pattern

SRC_MARK_START="###▼▼▼<src-updater-do-not-edit-or-remove>▼▼▼"
SRC_MARK_END="###▲▲▲<src-updater-do-not-edit-or-remove>▲▲▲"
# Marker for updating without messing up the file

splitA=.split.a.ignore.me
splitB=.split.b.ignore.me
# Names of the temporary files needed for splitting and re-joining
```
# How it works
0. Check `$file` exists and make a backup
1. Find the line containing the `$SRCname` with `grep`
2. Split the file into two files `$splitA` & `$splitB`
3. Append result of find command within the `$SRCdir` matching `$SRCfindptrn`
4. Append result of find command within the `$HEADERdir` matching `$HEADERfindptrn`
5. Re-join the two splits into `$file`

# Contribute
I am far from an expert in shell scripting, there's likely better ways to implement it.
So feel free to pull request, to upgrade and improve this script.
