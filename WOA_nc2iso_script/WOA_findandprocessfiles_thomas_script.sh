#!/bin/sh

#Find all WOA13 .nc files and copy them into input folder of nc2iso script
# find /nodc/web/woa.data.nodc/WOA13/data/ -name \*.nc -print0 | xargs -I{} -0 cp -v {} /nodc/projects/satdata/Granule_OneStop/WOA/WOA_nc2iso_thomas_script/input/

#Write input.txt file for nc2iso script based on .nc files in input folder
find /nodc/projects/satdata/Granule_OneStop/WOA/WOA_nc2iso_thomas_script/ -type f -printf "%f \n" -name "*.nc" > input.txt

FILENAME=input.txt
FILESIZE=$(stat -c%s "$FILENAME")
echo "$FILESIZE"
	if (($FILESIZE > 0)); then
		while read line
		do
			bash WOA_nc2iso_thomas_script.sh $line  ;
		done < input.txt;

	else
	echo "No .nc files found in input folder!"
	fi

echo "All done!"