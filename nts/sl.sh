#!/usr/bin/env bash

# Host record retrieval function
function host_record
{
	grep $1 /etc/hosts | tail -n1	
}

# Host check
function host_check
{
	if [ "$(host_record $1 | wc -l)" -eq 0 ]; then
		echo "unregistered"
		return 1	
	fi
	echo "registered"
	return 0
}

# Host record IP retrieval function
function host_ip
{
	host_record $1 | awk '{ print $1 }'
}

# Host system information
function host_system
{
	host_record $1 | awk '{ s = ""; for (i = 6; i <= NF; i++) s = s $i " "; print s }'
}

# Host record port retrieval function
function host_ports
{
	host_record $1 | awk '{ print $4 }'
}

# Host record SSH port retrieval function
function host_ssh
{
	host_ports $1 | awk 'BEGIN { FS = "/" } ; { print $1 }' | sed 's/^0*//' 
}

function host_ssh_up
{
	state="$(nc -zw 1 $1 $(host_ssh $1) 2>&1)"
	if [[ "$state" == *"succ"* ]]; then
		echo "available"
		return 0
	fi
	echo "unavailable"
	return 1
}

# Host record telnet port retrieval function
function host_telnet
{
	host_ports $1 | awk 'BEGIN { FS = "/" } ; { print $2 }' | sed 's/^0*//'
}

function host_telnet_up
{
	state="$(nc -zw 1 $1 $(host_telnet $1) 2>&1)"
	if [[ "$state" == *"succ"* ]]; then
		echo "available"
		return 0
	fi
	echo "unavailable"
	return 1
}

function set_title 
{ 
	echo -n -e "\033]0;$1\007" 
}

###############################################################################

if [ -z "$1" ]; then
	echo "usage: sl <host>"
	echo "Issue 'dls' command for registered host directory."
	exit
fi

if [ "$(host_check $1)" == "unregistered" ]; then
	echo "Host '$1' is not registered in the NTS!"
	exit	
else
	clear
	tput bold
	echo "*** NTS System Login"
	tput sgr0
	echo "Host: $1 @$(host_ip $1)"
fi

###############################################################################

echo -n "SSH..." 

if [ -z "$(host_ssh $1)" ]; then
	SSH_AVAIL="unavailable"
	echo -n "unavailable"
else
	SSH_PORT=$(host_ssh $1)
	SSH_AVAIL=$(host_ssh_up $1)
	echo -n "$SSH_PORT$([ "$SSH_AVAIL" == "unavailable" ] && echo -n " ($SSH_AVAIL)")"
fi

echo -n " // Telnet..."

if [ -z "$(host_telnet $1)" ]; then
	TELNET_AVAIL="unavailable"
	echo "unavailable"
else
	TELNET_PORT=$(host_telnet $1)
	TELNET_AVAIL=$(host_telnet_up $1)
	echo "$TELNET_PORT$([ "$TELNET_AVAIL" == "unavailable" ] && echo " ($TELNET_AVAIL)")"
fi

###############################################################################

if [ "$SSH_AVAIL" == "unavailable" ]; then
	if [ "$TELNET_AVAIL" == "unavailable" ]; then
		echo "Unable to login to $1: remote access services unavailable."
		exit
	fi
	echo "Accessing $1 (TN: @$TELNET_PORT) . . ." 
	set_title "NTS TTY: $1"
#	telnet -l $(whoami) $1 $TELNET_PORT 
	telnet $1 $TELNET_PORT 
	set_title "NTS Gateway: $(hostname)"
	exit	
elif [ "$SSH_AVAIL" == "available" ]; then
	echo "Accessing $1 (SSH: @$SSH_PORT) . . ." 
	set_title "NTS Secure Shell: $1"
	ssh -C -p $SSH_PORT $1
	set_title "NTS Gateway: $(hostname)"
	exit
fi

echo "Unable to login to $1: remote access services unavailable."

###############################################################################
