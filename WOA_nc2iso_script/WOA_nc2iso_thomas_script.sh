#!/bin/bash

#Function for generic error checking
function error_exit
{
	echo "$1" 1>&2
	exit 1
}

#WOA13 collection metadata template file
isocofile="/nodc/web/data.nodc/htdocs/nodc/archive/metadata/approved/iso/0114815.xml"

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
	#Apply modified UnidataDD2MI XSL to work with WOA data
	xsltproc XSL/ncml2iso_modified_from_UnidataDD2MI_demo_WOA_Thomas_edits.xsl $filename.ncml > $filename.xml
	#Apply collection metadata
	xsltproc --stringparam collFile $isocofile XSL/granule.xsl $filename.xml > output/$filename.xml
else 
	error_exit "Something went wrong with xsltproc, program exiting."
fi

rm out.nc
rm $filename.ncml
rm $filename.xml

echo "$filename.xml successfully written to output directory."

exitcode=$?
	exit $exitcode