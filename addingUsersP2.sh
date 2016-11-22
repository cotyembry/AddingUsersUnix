#!/usr/local/bin/bash
#/bin/bash





#         Author:		John Coty Embry
#           Date:		11-10-2016
#Program Comment:		This script will erase and overwrite a new_users.txt file and output its own text to the new_users.txt file (or will create the new_users.txt file if it doens't exist) within the same level of the directory tree relative to where this script is ran

#   Dependencies:
#		relative to where this script sets:
#			./cs_roster.txt,
#			/etc/passwd


#-------Assignment
#Write a script that will take input from cs_roster.txt made available by the IT department and generate the new_users.txt file that is used as input for the script in Adding Users - Part 1.

# No accounts should be created for students enrolled in CMPSC 1513
# No accounts should be created for students enrolled in any course with CPSMA as a prefix except CPSMA 2923 which is our Data Structures class
# The major code for Computer Science is 0510.
# Any student that has declared Computer Science as his/her first or second major should have their home directory in /home/STUDENTS/majors
# Any student that does not have Computer Science as a major should have home directory in /home/STUDENTS/nonmajors
#use the cs_roster.txt file for input directory from my home directory /home/faculty/mkt
#-------

#helpers for later
majorCodeForComputerScience=0510
majorDirectory='/home/STUDENTS/majors'
nonmajorDirectory='/home/STUDENTS/nonmajors'
shellDirectory='/user/local/bin/bash'

#before starting, I will clear out the file then later I will just append to the file
echo -n '' > new_users.txt #-n means do not include a newline at the end

#mkdir -p /home/faculty/mkt/unix_admin/EMBRY_JOHN #make the directory if it doesn't exist already

(
	while read line; do
			
		username=$(echo $line | cut -d '|' -f2)
		#Here I will make an assumption and say if username is empty then the line is blank and I will skip blank lines for the output
		#echo ">${username}<"
		emptyLineFlag=0
		if [ "$username" == "" ]; then
			emptyLineFlag=1
		fi


		password=x
		uid=x
		gid=x
		fullname=$(echo $line | cut -d '|' -f3)	
		ecuid=$(echo $line | cut -d '|' -f4)
		GECOS=${fullname}+${ecuid}
		majorCode=$(echo $line | cut -d '|' -f5)
		secondMajorCode=$(echo $line | cut -d '|' -f6)
		coursePrefix=$(echo $line | cut -d '|' -f1 | cut -d ' ' -f1)
		courseNumber=$(echo $line | cut -d '|' -f1 | cut -d ' ' -f2)

		doNotCreateUser=0 #default it to false before starting the logic

		isMajor=0 #I will use this to help me determine whether to put the student in /home/STUDENTS/majors or not

		if [ "$coursePrefix" == "CMPSC" ]; then
			if [ "$courseNumber" == "1513"  ]; then
				#echo not adding $fullname
				doNotCreateUser=1
			fi
		fi
		
		#now I have filtered out the CMPSC 1513 course so if they are enrolled in this course for this iteration through the file, then the doNotCreateUser flag will be set to 1

		#now to check to see if the student is enrolled in CPSMA and if they are it must only be course 2923

		if [ "$coursePrefix" == "CPSMA" ]; then
			if [ "$courseNumber" != "2923" ]; then
				#if here, per the instructions do not create an account for this iteration
				doNotCreateUser=1
			fi
		fi

		#now I have filtered out the CPSMA course prefix people. If they were enrolled in this course prefix they will not be added as a user, but if they had CPSMA 2923, this would be the only exception to allow them to have an account created

		#continue to step 3.
		#to add the user or not...check using above flag. Then its time to go either major or nonmajor


		#but first, one last thing needs to be checked. If the user is already in the
		#system, then they do not need to be added

		#it'd be better to go through this one time above and store the usernames in an array
		#then I could loop through it one time in memory rather than opening the files
		(
			while read line2; do
				etcUsername=$(echo $line2 | cut -d ':' -f1)
				if [ "$etcUsername" == "$username" ]; then
					doNotCreateUser=1
				fi
			done
		) < /etc/passwd #passwd.txt




		#also make sure to skip empty lines in the file
		if [ "$emptyLineFlag" == "0" ]; then
			if [ "$doNotCreateUser" == "0" ]; then
				#see if the major code of this person is a Computer Science major
				if [ "$majorCode" == "$majorCodeForComputerScience" ]; then
					#the format for the line to output is
					#username:password:uid:gid:GECOS:homedir:shell
					# echo $fullname $majorDirectory
					echo ${username}:${password}:${uid}:${gid}:${GECOS}:${majorDirectory}:${shellDirectory} >> new_users.txt
				elif [  "$secondMajorCode" == "$majorCodeForComputerScience" ]; then
					#this flow covers any students with their second major declared as computer science
					echo ${username}:${password}:${uid}:${gid}:${GECOS}:${majorDirectory}:${shellDirectory} >> new_users.txt
				else
					#the format for the line to output is
					#username:password:uid:gid:GECOS:homedir:shell
					# echo $fullname	$nonmajorDirectory
					echo ${username}:${password}:${uid}:${gid}:${GECOS}:${nonmajorDirectory}:${shellDirectory} >> new_users.txt
				fi

			fi
		fi		
	done
) < cs_roster.txt #/home/faculty/mkt/unix_admin/cs_roster.txt
