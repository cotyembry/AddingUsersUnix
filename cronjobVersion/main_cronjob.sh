#!/bin/bash
#/usr/local/bin/bash




#-------
# i. Execute script Adding Users – Part 2
# ii. Execute script Adding Users – Part 1
# iii. Execute script Modifying Users
# iv. Execute command that will list the contents of your crontab and redirect the listing output to
# /home/faculty/mkt/unix_admin/LAST_FIRST/list_crontab.txt
#-------

mkdir -p /home/faculty/mkt/unix_admin/EMBRY_JOHN #make the directory if it doesn't exist already


./addingUsersP2_cronjobVersion.sh

./addingUsersP1_cronjobVersion.sh

./modifyUsers_cronjobVersion.sh

crontab -l > /home/faculty/mkt/unix_admin/EMBRY_JOHN/list_crontab.txt



