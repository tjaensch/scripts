Convert WOA netCDF .nc file to ISO metadata .xml - 4/14/2016

1. On ammonite, CD into script directory

2. Add source .nc file you want to convert into script directory (use the .nc file that's already there or other example files from the parent directory)

3. Run "bash WOA_nc2iso_thomas_script.sh"

4. Follow shell prompts

If everything worked out, the script will write an ISO .xml file based on the .nc input file to the output directory.


-----

Below some instructions from Li I used to write the script

> if on ammonite (because of netCDF-3 vs netCDF-4):

nccopy -k classic in.nc out.nc

> ncdump -x out.nc>file.ncml

> Replace the second line in the ncml file with <netcdf>

> xsltproc *_demo.xsl file.ncml > file.xml

The file.xml is the ISO19115-2 metadata based on the ncISO standard.
The demo file was one of the GHRSST Pathfinder v5.2 file. Please reference the table https://docs.google.com/spreadsheets/d/1TY3y9vYmr2eHN4c_6dU-o6OBi-LMJC-E6txc2i_tFjw/edit for the datasets you will be working with. Please try the xslt with your datasets. If any information is missing from the output ISO metadata, you will need to modify the xslt to make it work. 

More information:
netCDF template
http://www.nodc.noaa.gov/data/formats/netcdf/v1.1/ 
Please use this as a reference for standard way of the attribute names. 

ncISO tamplate
https://geo-ide.noaa.gov/wiki/index.php?title=NcISO
This wiki also provide introduction about the xslt that ncISO uses. This xslt was used as the basis of our metadata transformation. 

ISO metadata
https://geo-ide.noaa.gov/wiki/index.php?title=ISO_19115_and_19115-2_CodeList_Dictionaries 
