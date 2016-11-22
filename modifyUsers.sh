#!/bin/bash
#/usr/local/bin/bash



#Author:	John Coty Embry
#  Date:	11-10-2016

#-------
#Name Changes 
#Note: May include both username and GECOS field modifications
#Major Changes
#Note: May include changing to or from Computer Science major and should result in appropriate placement of home directory.
#-------

echo -n '' > changeMe.txt #to clear the file out

(
while read line; do
	#bijach:Acharya, Bijay:222446
	
	ecuid=$(echo $line | cut -d ':' -f3)
	fullname=$(echo $line | cut -d ':' -f2)


	#echo "usermod -l newUsername oldUsername"
	#usermod –c “User for transfer files” transfer_user

	#has the name changed? Time to find out
	(
		while read line2; do
			echo $line2

		done
	) < /etc/passwd




	#echo "usermod -c \"${}${}\""



done
) < active_cs.txt

