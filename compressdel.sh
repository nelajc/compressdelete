#!/bin/sh
today=`date +%Y-%m-%d`
logroot="/cygdrive/c/IIS/_log"
releaseroot="/cygdrive/c/IIS/release"

echo -e `date '+%b-%d-%Y %r'`"\r" >> /cygdrive/c/IIS/scriptlogs.txt
#====================================IIS LOGS=========================================#
cd $logroot
for folders in $(ls); do
	if [[ -d $folders ]]; then
		cd $folders
		for file in $(ls); do
			if [ $file != $today ] && [[ ! $file =~ [.tar.gz$] ]]; then
				tar -zcf $file.tar.gz $file
				echo -e "Succesfully compressed $file \r" >> /cygdrive/c/IIS/scriptlogs.txt
				rm -r $file
				echo -e "Succesfully DELETED $file \r" >> /cygdrive/c/IIS/scriptlogs.txt
				find . -type f -name '*.tar.gz' -mtime +30 -exec ls {} \;
			fi
		done
		cd $logroot
	fi
done
#======================================END===========================================#

cd $releaseroot
for dir in $(ls); do
	if [[ -d $dir ]]; then
		cd $dir/attachment
			find . -type f -name '*.jpg' -mtime +30 -exec ls {} \;
			find . -type f -name '*.png' -mtime +30 -exec ls {} \;
		cd $releaseroot
	fi
done
