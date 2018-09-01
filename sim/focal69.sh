#!/usr/bin/env bash
#################################################
# FOCAL69: SimH emulated FOCAL,1969 environment #
#################################################
                                                #
SIM="/usr/local/bin/pdp8 -q"                    #
CONFIG=/usr/share/simh/configs/pdp8-focal.simh  #
MSG=/usr/share/simh/msg/focal69.msg             #
LOGFILE=lastsession_focal69                     #
SRCFILE=lastlisting.fcl69                       #
                                                #
#################################################
#        DO NOT MODIFY BELOW THIS POINT         #
#################################################
mkdir -p $HOME/sim/focal69                      #
pushd $HOME/sim/focal69 > /dev/null             #
rm -f $LOGFILE                                  #
touch $LOGFILE                                  #
[[ -f $MSG ]] && cat $MSG                       #
echo "(send ^E to halt/exit)"                   #
$SIM $CONFIG                                    #
dos2unix $LOGFILE > /dev/null                   #
/usr/local/bin/getfcl $LOGFILE $SRCFILE         #
popd > /dev/null                                #
#################################################
