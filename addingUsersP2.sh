#!/bin/bash

#/usr/local/bin/bash #not using because of developing on my Mac

#Author:	John Coty Embry
#Date:		11-10-2016

#-------
#Write a script that will take input from cs_roster.txt made available by the IT department and generate the new_users.txt file that is used as input for the script in Adding Users - Part 1.

#Please note:
#	1. No accounts should be created for students enrolled in CMPSC 1513
#	2. No accounts should be created for students enrolled in any course with CPSMA as a prefix except CPSMA 2922 which is our Data Structures class.
#	3. The major code for Computer Science is 0510
#	4. Any student that does not have Computer Science declared as his/her first or second major should have their home directory in /home/STUDENTS/majors
#	5. Any student that does not have Computer Science as a major should have home directory in /home/STUDENTS/nonmajors

#use the cs_roster.txt file for input directory from my home directory /home/faculty/mkt
#-------

majorCodeForComputerScience=0510
majorDirectory='/home/STUDENTS/majors'
nonmajorDirectory='/home/STUDENTS/nonmajors'

(
while read line; do
		
	username=$(echo $line | cut -d '|' -f2)
	password=x
	uid=x
	gid=x
	fullname=$(echo $line | cut -d '|' -f3)	
	ecuid=$(echo $line | cut -d '|' -f4)
	GECOS=${fullname}+${ecuid}
	majorCode=$(echo $line | cut -d '|' -f5)
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

	if [ "$doNotCreateUser" == 0  ]; then
		#see if the major code of this person is a Computer Science major
		if [ "$majorCode" == "$majorCodeForComputerScience"  ]; then
			echo $fullname $majorDirectory
		else
			echo $fullname	$nonmajorDirectory
		fi

	fi





done
) < cs_roster.txt


