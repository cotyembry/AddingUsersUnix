#!/bin/bash
#/usr/local/bin/bash



#Author:	John Coty Embry
#  Date:	11-10-2016


echo -n '' > changeMe.txt #to clear the file out

(
while read line; do



	username=$(echo $line | cut -d ':' -f1)
	GECOS=$(echo $line | cut -d ':' -f5)
	homedir=$(echo $line | cut -d ':' -f6)

	echo "useradd -md $homedir -c \"${GECOS}\" -s /user/local/bin/bash -k /home/csadmin/SKEL $username" >> changeMe.txt


done
) < new_users.txt

