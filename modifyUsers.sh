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
					echo "usermod -c \"${fullname}+${ecuid}\""
				fi

				#now see if their user id has changed
				if [ "$username" != "$etcUsername" ]; then
					#the username has changed and needs to be updated
					echo "usermod -l $username  $etcUsername"
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
				) < cs_roster.txt


				#awesome, I have flags now to tell me if the student is a major or not
				#now to use them
				if [ "$isMajor" == "1" ]; then
					etcCurrentDirectory=$(echo $line2 | cut -d ':' -f5 | cut -d '/' -f4)
					if [ "majors" != "$etcCurrentDirectory" ]; then
						#if they are a major but their current directory is not in the majors directory
					

						#todo, finish this
					

					fi


					#the username has changed and needs to be updated
					# echo "usermod -l $username  $etcUsername"
				elif [ "$isMajor" == "0" ]; then
					

					#todo, finish this


				fi
			fi
		done
	) < ./etc/passwd



	#Im done with the flow for users that already existed
	#If I wanted to address any issues for users that didnt already exist
	#in the etc/passwd file I could do that here




done
) < active_cs.txt

