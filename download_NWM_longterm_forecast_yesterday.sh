#!/bin/bash
# Get NWM short, medium, and long range forecast data
# http://www.nco.ncep.noaa.gov/pmb/products/nwm/
# This script is used to download one day forecast

# download one day forecast channel routing index.html
cd /your path/

rm index.html*
rm origionalnamechannel.txt
rm origionalnameland.txt

attention="PLEASE ATTENTION PLEASE ATTENTION PLEASE ATTENTION!!!"
  
bechan=0
beland=0  
  
yesterday=$(date -d "-1 day" +%Y%m%d)
 
for mem in {1..4}
do
    site="https://nomads.ncep.noaa.gov/pub/data/nccf/com/nwm/prod/nwm."$yesterday"/long_range_mem"$mem"/"
    wget $site
    grep "channel_rt" index.html>origionalnamechannel.txt
    
    while IFS='' read -r line || [[ -n "$line" ]]; do
        myfile[$index]="$line"
        #echo "${myfile[$index]}"
        index=$(($index+1))
    done < origionalnamechannel.txt

    count=$bechan
    index=$(($index-1))
    until [ $count -gt $index ]
    do  
        outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:26}""	
		downname=""$site""${myfile[$count]:9:46}""
		
        wget -O $outname  $downname
        count=$(($count+1))
		
		sleep 2s
    done  

    count=$bechan
    until [ $count -gt $index ]
    do 
          outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:26}""
          FILESIZE=$(stat -c%s "$outname")
          if [ $FILESIZE -le 2000 ]
          then  
		     downname=""$site""${myfile[$count]:9:46}""
             wget -O $outname  $downname
          fi  
          count=$(($count+1))
    done

    count=$bechan
    until [ $count -gt $index ]
    do 
          outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:26}""
          FILESIZE=$(stat -c%s "$outname")
          if [ $FILESIZE -le 2000 ]
          then  
		     downname=""$site""${myfile[$count]:9:46}""
             wget -O $outname  $downname
          fi  
          count=$(($count+1))
    done
	
    count=$bechan
    until [ $count -gt $index ]
    do 
          outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:26}""
          FILESIZE=$(stat -c%s "$outname")
          if [ $FILESIZE -le 2000 ]
          then  
             echo $attention
             echo $outname
          fi  
          count=$(($count+1))
    done
	
	#------------------------------------------------------------------------------------------------------------------------------------------------
    # download one day Land Output forecast index.html
    grep "land_" index.html>origionalnameland.txt

    index=0
    while IFS='' read -r line || [[ -n "$line" ]]; do
        myfile[$index]="$line"
        #echo "${myfile[$index]}"
        index=$(($index+1))
    done < origionalnameland.txt

    count=$beland
    index=$(($index-1))
    until [ $count -gt $index ]
    do  
        outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:20}"" 	
		downname=""$site""${myfile[$count]:9:40}""
		
        wget -O $outname  $downname
        count=$(($count+1))
    done  

    count=$beland
    until [ $count -gt $index ]
    do 
          outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:20}"" 
          FILESIZE=$(stat -c%s "$outname")
          if [ $FILESIZE -le 2000 ]
          then  
		     downname=""$site""${myfile[$count]:9:40}""
             wget -O $outname  $downname
          fi  
          count=$(($count+1))
    done
    
    count=$beland
    until [ $count -gt $index ]
    do 
          outname="/your path/mem"$mem""/""$yesterday""${myfile[$count]:12:6}""${myfile[$count]:29:20}"" 
          FILESIZE=$(stat -c%s "$outname")
          if [ $FILESIZE -le 2000 ]
          then  
             echo $attention
             echo $outname
          fi  
          count=$(($count+1))
    done 
done





