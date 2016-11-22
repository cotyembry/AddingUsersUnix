#!/usr/local/bin/bash
#/bin/bash


#Author:	John Coty Embry
#  Date:	11-10-2016


#Dependencies:
#	3 files:	/home/faculty/mkt/unix_admin/cs_roster.txt
#				/home/faculty/mkt/unix_admin/active_cs.txt,
#			 	/etc/passwd



#-------
#Name Changes 
#Note: May include both username and GECOS field modifications
#Major Changes
#Note: May include changing to or from Computer Science major and should result in appropriate placement of home directory.
#-------


# input: /home/faculty/mkt/unix_admin/active_cs.txt
#output: /home/faculty/mkt/unix_admin/LAST_FIRST/modified_users.txt


majorCodeForComputerScience=0510
majorDirectory='/home/STUDENTS/majors'
nonmajorDirectory='/home/STUDENTS/nonmajors'

echo -n '' > modified_users.txt #to clear the file out

(
while read line; do

	isMajor=0
	userAlreadyExisted=0
	ecuid=$(echo $line | cut -d ':' -f3)
	fullname=$(echo $line | cut -d ':' -f2)
	username=$(echo $line | cut -d ':' -f1)
	etcCurrentDirectory=''
	

	#echo "usermod -l newUsername oldUsername"
	#usermod –c “User for transfer files” transfer_user

	#has the name changed? Time to find out
	(
		while read line2; do
			userFullName=$(echo $line2 | cut -d ':' -f5 | cut -d '+' -f1)
			userECUId=$(echo $line2 | cut -d ':' -f5 | cut -d '+' -f2)
			etcUsername=$(echo $line2 | cut -d ':' -f1)

			if [ "$ecuid" == "$userECUId" ]; then
				userAlreadyExisted=1
				#now that I have located the user in the file, time to see if the name has changed
				if [ "$fullname" != "$userFullName" ]; then
					#if here then the users full name has changed and needs to be updated
					#here I will assume that the active_cs.txt file has the sayso on which
					#name is more current so I will use the full name from the active_cs.txt file
					echo "usermod -c \"${fullname}+${ecuid}\"" >> modified_users.txt
				fi

				#now see if their username has changed
				if [ "$username" != "$etcUsername" ]; then
					#the username has changed and needs to be updated
					echo "usermod -l $username $etcUsername" >> modified_users.txt
				fi

				#also I need to account for:
				#May include changing to or from Computer Science major and should result in appropriate placement of home directory
				#I have to do the next while loop to see if the person is an a major or non major
				(
					while read line3; do
						csRosterUserId=$(echo $line3 | cut -d '|' -f4)
						majorCode=$(echo $line3 | cut -d '|' -f5)
						secondMajorCode=$(echo $line3 | cut -d '|' -f6)
						
						if [ "$ecuid" == "$csRosterUserId" ]; then
							#now that I've found the person in this file, time to compare and see if this student is a major or nonmajor
							if [ "$majorCode" == "$majorCodeForComputerScience" ]; then
								isMajor=1
							elif [ "$secondMajorCode" == "$majorCodeForComputerScience" ]; then
								isMajor=1
							else
								#if they dont have the major code declared in the major or secondary major parts then their directory needs to be /home/STUDENTS/nonmajors/
								isMajor=0
							fi
						fi
					done
				) < /home/faculty/mkt/unix_admin/cs_roster.txt #change this to point to /home/faculty/mkt/cs_roster.txt after done with the assignment


				#awesome, I have flags now to tell me if the student is a major or not
				#now to use them
				etcCurrentDirectory=$(echo $line2 | cut -d ':' -f5 | cut -d '/' -f4)

				if [ "$isMajor" == "1" ]; then	
					if [ "majors" != "$etcCurrentDirectory" ]; then
						#if they are a major but their current directory is not in the majors directory
						#I need to change their directory
						#the -m moves the content of their home directory also
						echo "usermod -m -d /home/STUDENTS/majors/${username}" >> modified_users.txt
					fi
				elif [ "$isMajor" == "0" ]; then
					if [ "majors" == "$etcCurrentDirectory" ]; then
						#if the student is not a major and they have the majors directory, they need to be moved to the nonmajors directory
						echo "usermod -m -d /home/STUDENTS/nonmajors/${username}" >> modified_users.txt
					fi
				fi
			fi
		done
	) < /etc/passwd #change this to point to /etc/passwd after done with the assignment



	#Im done with the flow for users that already existed
	#If I wanted to address any issues for users that didnt already exist
	#in the etc/passwd file I could do that here




done
) < /home/faculty/mkt/unix_admin/active_cs.txt #change this to point to /home/faculty/mkt/active_cs.txt after done with the assignment

