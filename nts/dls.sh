#!/usr/bin/env bash
echo "Directory of registered NTS hosts [ADDR/NAME/SSH/TN/OS/SYS] *******************"
sed -e '1,/NTS HOST DIRECTORY/d' /etc/hosts
echo "*******************************************************************************"
echo "Issue command 'ntstat' for availability or 'sl <host>' to log in."
