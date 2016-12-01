#!/bin/bash
#/usr/local/bin/bash

#Author:	John Coty Embry
#  Date:	11-10-2016


#-------
# i. Execute script Adding Users – Part 2
# ii. Execute script Adding Users – Part 1
# iii. Execute script Modifying Users
# iv. Execute command that will list the contents of your crontab and redirect the listing output to
# /home/faculty/mkt/unix_admin/LAST_FIRST/list_crontab.txt
#-------

mkdir -p /home/faculty/mkt/unix_admin/EMBRY_JOHN #make the directory if it doesn't exist already

# Execute command that will remove all files located within
# /home/faculty/mkt/unix_admin/LAST_FIRST/
#rm -r /home/faculty/mkt/unix_admin/EMBRY_JOHN/*

./addingUsersP2_cronjobVersion.sh

./addingUsersP1_cronjobVersion.sh

./modifyUsers_cronjobVersion.sh

crontab -l > /home/faculty/mkt/unix_admin/EMBRY_JOHN/list_crontab.txt

# Schedule execution of final script:
# a. Edit your crontab to execute your final script based on the following schedule:
# i. 9:15am on Tuesday, November 22nd
# ii. Daily at 4:30pm

#minute hour day month day-of-week command-line-to-execute
#this part is done now and has been edited in my crontab file using the crontab -e command

