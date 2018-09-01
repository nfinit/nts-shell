#!/usr/bin/env bash
#################################################
#  FOCAL15: SimH emulated FOCAL-15 environment  #
#################################################
                                                #
SIM="/usr/local/bin/pdp15 -q"                   #
CONFIG=/usr/share/simh/configs/pdp15-focal.simh #
MSG=/usr/share/simh/msg/focal15.msg             #
                                                #
#################################################
#        DO NOT MODIFY BELOW THIS POINT         #
#################################################
[[ -f $MSG ]] && cat $MSG                       #
echo -n "(send ^E to halt/exit)"                #
$SIM $CONFIG                                    #
#################################################
