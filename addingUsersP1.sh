#!/bin/bash
#/usr/local/bin/bash


#Author:	John Coty Embry
#  Date:	11-10-2016

#  Note:	This script will delete a file in the directory that is located where this script sits on the computer that is named 'added_users.txt' and add its own contents to the file


#-------
#Write a shell script that will generate the command to add each user. This command must include each of the following:
#1.	Username
#2.	GECOS
#3.	Home directory
#4.	Create home directory and load skeleton files from a directory /home/csadmin/SKEL
#5.	Specify shell
#Your Program should DISPLAY the command for each record on the screen. DO NOT attempt to actually execute the command to add the users.
#-------


#the command should probably look like the following literally:
#	useradd -md ${homedir} -c "${GECOS}" -s /user/local/bin/bash -k /home/csadmin/SKEL ${username} 

#now I need to get the 4 variable values for each line in the new_users.txt file

echo -n '' > added_users.txt #to clear the file out

(
while read line; do



	username=$(echo $line | cut -d ':' -f1)
	GECOS=$(echo $line | cut -d ':' -f5)
	homedir=$(echo $line | cut -d ':' -f6)

	echo "useradd -md $homedir -c \"${GECOS}\" -s /user/local/bin/bash -k /home/csadmin/SKEL $username" >> added_users.txt


done
) < new_users.txt

