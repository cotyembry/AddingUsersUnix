#!/usr/local/bin/bash
#/bin/bash




#Author:	John Coty Embry
#  Date:	11-10-2016

#  Note:	This script will delete a file in the directory that is located where this script sits on the computer that is named 'added_users.txt' and add its own contents to the file


# Adding Users – Part 1
# Input: new_users.txt (local file)
# Output: /home/faculty/mkt/unix_admin/LAST_FIRST/added_users.txt


#the command should probably look like the following literally:
#	useradd -md ${homedir} -c "${GECOS}" -s /user/local/bin/bash -k /home/csadmin/SKEL ${username} 

#now I need to get the 4 variable values for each line in the new_users.txt file

echo -n '' > /home/faculty/mkt/unix_admin/EMBRY_JOHN/added_users.txt #added_users.txt #to clear the file out

mkdir -p /home/faculty/mkt/unix_admin/EMBRY_JOHN #make the directory if it doesn't exist already

(
while read line; do

	username=$(echo $line | cut -d ':' -f1)
	GECOS=$(echo $line | cut -d ':' -f5)
	ecuid=$(echo $line | cut -d ':' -f5 | cut -d '+' -f2)
	homedir=$(echo $line | cut -d ':' -f6)


	lineResult=$(grep $ecuid /etc/passwd)
	if [ "$lineResult" == "" ]; then
		#i.e. the users id was not found in /etc/passwd
		echo "useradd -md $homedir -c \"${GECOS}\" -s /usr/local/bin/bash -k /home/csadmin/SKEL $username" >> /home/faculty/mkt/unix_admin/EMBRY_JOHN/added_users.txt #added_users.txt	
	fi


done
) < new_users.txt

