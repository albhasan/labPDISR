#!/bin/bash
export SCRIPT_PATH=`readlink /proc/$$/fd/255`
export PROJECT_FOLDER="$(dirname ${SCRIPT_PATH})"
#export PROJECT_FOLDER=/media/data/ghProjects/labPDISR
cd $PROJECT_FOLDER
echo "#####################################################"
echo "LAB - Processamento Digital De Imagens De Sensores Remotos"
echo "Base folder: " $PROJECTFOLDER
echo "#####################################################"



#####################################################
# PROJECT VARIABLES
#####################################################
export TEST=1
export GETDATA=1

export SOURCES_FOLDER=$PROJECT_FOLDER/sources
export RESULTS_FOLDER=$PROJECT_FOLDER/results
export TMP_FOLDER=$PROJECT_FOLDER/tmp

# It must macth the zipped grass db
export GRASS_DB=$PROJECT_FOLDER/gdb/grassDB
export PROJECT_LOCATION=grassDB
export PROJECT_MAPSET=PERMANENT


#####################################################
# GRASS VARIABLES
#####################################################
export GISBASE=/usr/lib/grass70
export PATH=$PATH:$GISBASE/bin:$GISBASE/scripts
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GISBASE/lib
export GIS_LOCK=$$
export GISRC=$PROJECT_FOLDER/rc


#####################################################
#echo "-- cleaning old runs..."
#####################################################
rm -rf $PROJECT_FOLDER/gdb
rm -rf $TMP_FOLDER
rm -rf $RESULTS_FOLDER
rm $PROJECT_FOLDER/rc
mkdir $PROJECT_FOLDER/gdb
mkdir $TMP_FOLDER
mkdir $RESULTS_FOLDER


#####################################################
echo "-- getting the data..."
#####################################################
if [ $GETDATA -eq 1 ]; then
	rm -rf $SOURCES_FOLDER
	mkdir $SOURCES_FOLDER
	
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/sjc-wv2-3200x2400-regiao1.tif
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/sjc-wv2-3200x2400-regiao1.tfw
	
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/LE72190762015194CUB00.zip
	unzip -d $SOURCES_FOLDER $SOURCES_FOLDER/LE72190762015194CUB00.zip
	
	#wget -P $TMP_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/LE72190762015194CUB00.zip
	#unzip -d $TMP_FOLDER $TMP_FOLDER/LE72190762015194CUB00.zip
	#export PHOTO_PROJ=$(gdalinfo -proj4 $SOURCES_FOLDER/sjc-wv2-3200x2400-regiao1.tif | grep +proj)
	#export LANDSAT_PROJ=$(gdalinfo -proj4 $TMP_FOLDER/LE72190762015194CUB00.tif | grep +proj)
	#gdalwarp -s_srs "$LANDSAT_PROJ" -t_srs "$PHOTO_PROJ" $TMP_FOLDER/LE72190762015194CUB00.tif $SOURCES_FOLDER/proj_LE72190762015194CUB00.tif
	#gdalwarp -s_srs '+proj=utm +zone=23 +datum=WGS84 +units=m +no_defs ' -t_srs '+proj=utm +zone=23 +south +datum=WGS84 +units=m +no_defs ' $TMP_FOLDER/LE72190762015194CUB00.tif $SOURCES_FOLDER/proj_LE72190762015194CUB00.tif
fi 





#####################################################
#echo "-- creating a grass db..."
#####################################################
echo "GISDBASE: $PROJECT_FOLDER/gdb"					>> $PROJECT_FOLDER/rc
echo "LOCATION_NAME: $PROJECT_LOCATION" 	>> $PROJECT_FOLDER/rc
echo "MAPSET: $PROJECT_MAPSET" 						>> $PROJECT_FOLDER/rc
echo "GUI: text" 														>> $PROJECT_FOLDER/rc
tar -xzf $PROJECT_FOLDER/grassDB.tar.gz -C $PROJECT_FOLDER/gdb


#####################################################
#echo "-- importing data..."
#####################################################
r.in.gdal input=$SOURCES_FOLDER/sjc-wv2-3200x2400-regiao1.tif output=sjc-wv2-3200x2400-regiao1
r.in.gdal location=landsat_loc input=$SOURCES_FOLDER/LE72190762015194CUB00.tif output=LE72190762015194CUB00


#####################################################
#echo "-- re-projecting..."
#####################################################
r.proj input=LE72190762015194CUB00.red location=landsat_loc 		dbase=$PROJECT_FOLDER/gdb output=landsat.red
r.proj input=LE72190762015194CUB00.blue location=landsat_loc 	dbase=$PROJECT_FOLDER/gdb output=landsat.blue
r.proj input=LE72190762015194CUB00.green location=landsat_loc 	dbase=$PROJECT_FOLDER/gdb output=landsat.green





echo "-- final cleaning..."



