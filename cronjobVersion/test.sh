#!/usr/local/bin/bash



#2 things I now need to deal with

#one:	if the user is in active_cs.txt and has their home directory in nonmajors it needs to be changed to majors
#two:	if the user is not in active_cs.txt and has their home directory in majors it needs to be changed to nonmajors


majorsResult=$(grep STUDENTS/majors /etc/passwd)
#nonMajorsResult=$(grep STUDENTS/nonmajors/ /etc/passwd)

echo  "$majorsResult" > ./majorsResult.txt
#echo -n "" > ./nonmajorsResult.txt

#this first for loop makes a file that is just the majors
#for i in $majorsResult; do

#	echo $i #>> majorsResult.txt

#done





#this first for loop makes a file that is just the nonmajors
#for i in $nonmajorsResult; do

#	echo "${nonmajorsResult}" >> nonmajorsResult.txt

#done

#one:	if the user is in active_cs.txt and has their home directory in nonmajors it needs to be changed to majors

#(
#	while read myLine; do
#		ecuid=$(echo $myLine | cut -d ':' -f3)
#		fullname=$(echo $myLine | cut -d ':' -f2)
#		username=$(echo $myLine | cut -d ':' -f1)		
	
#		grepResult=$(grep $ecuid ./majorsResult.txt | head -1)

#		if [ "$grepResult" == ""  ]; then
			#if here then the users directory is in the nonmajors directory and needs to be moved to the majors directory
#			echo "usermod -m -d /home/STUDENTS/majors/${username} $username" >> /home/faculty/mkt/unix_admin/EMBRY_JOHN/modified_users.txt
#		fi


#	done

#) < /home/faculty/mkt/unix_admin/active_cs.txt


#two:	if the user is not in active_cs.txt and has their home directory in majors it needs to be changed to nonmajors


#(
#	while read myLine; do

#		userFullName=$(echo $myLine | cut -d ':' -f5 | cut -d '+' -f1)
#		userECUId=$(echo $myLine | cut -d ':' -f5 | cut -d '+' -f2)
#		username=$(echo $myLine | cut -d ':' -f1)	
		

		
#		grepResult=$(grep $userECUId /home/faculty/mkt/unix_admin/active_cs.txt)

#		if [ "$grepResult" == ""  ]; then
			#if here the user is not in the active_cs.txt file but is in majors directory			
#			echo "usermod -m -d /home/STUDENTS/nonmajors/${username} $username" >> /home/faculty/mkt/unix_admin/EMBRY_JOHN/modified_users.txt			
#		fi

#	done

#) < ./majorsResult.txt



#now that I have went through both the 

#cleanup the directory
#rm ./majorsResult.txt
#rm ./nonmajorsResult.txt

