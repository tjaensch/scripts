#!/bin/bash

#Function for generic error checking
function error_exit
{
	echo "$1" 1>&2
	exit 1
}

echo -n "Enter an .nc file name (just the name without the file extension) > "
read filename

if [ -z "$filename" ]; then
	error_exit "File not available, program exiting."
fi

if nccopy -k classic $filename.nc out.nc; then
	ncdump -x out.nc > $filename.ncml
else
	error_exit "Something went wrong with nccopy/ncdump, program exiting."
fi	

#Replace the second line in the ncml file with <netcdf>
if sed -i '2 c\ \<netcdf\>' $filename.ncml; then
	xsltproc XSL/ncml2iso_modified_from_UnidataDD2MI_demo_WOA_Thomas_edits.xsl $filename.ncml > output/$filename.xml
else 
	error_exit "Something went wrong with xsltproc, program exiting."
fi

rm out.nc
rm $filename.ncml

echo "$filename.xml successfully written to output directory."

exitcode=$?
	exit $exitcode