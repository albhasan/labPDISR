#!/bin/bash

#####################################################
# DIGITAL IMAGE PROCESSING USING GRASS ADN BASH
# NOTES:
#		- Dependencies: grass70, gdal2 with HDF4 support
#####################################################




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
export TEST=0
export GETDATA=0

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
echo "-- cleaning old runs..."
#####################################################
rm -rf $PROJECT_FOLDER/gdb
rm -rf $TMP_FOLDER
rm -rf $RESULTS_FOLDER
rm $PROJECT_FOLDER/rc
mkdir $PROJECT_FOLDER/gdb
mkdir $TMP_FOLDER
mkdir $RESULTS_FOLDER

if [ $GETDATA -eq 1 ]; then
	rm -rf $SOURCES_FOLDER
	mkdir $SOURCES_FOLDER

	# Photo
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/sjc-wv2-3200x2400-regiao1.tif
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/sjc-wv2-3200x2400-regiao1.tfw

	# Landsat
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/LC82180762015195LGN00.tar.gz
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/LC82190762014039LGN00.tar.gz
	wget -P $SOURCES_FOLDER https://dl.dropboxusercontent.com/u/25989010/labPDI/LC82190762014215LGN00.tar.gz
	tar -zxf $SOURCES_FOLDER/LC82180762015195LGN00.tar.gz -C $SOURCES_FOLDER
	tar -zxf $SOURCES_FOLDER/LC82190762014039LGN00.tar.gz -C $SOURCES_FOLDER
	tar -zxf $SOURCES_FOLDER/LC82190762014215LGN00.tar.gz -C $SOURCES_FOLDER
fi


#####################################################
echo "-- creating a grass db..."
#####################################################
echo "GISDBASE: $PROJECT_FOLDER/gdb"					>> $PROJECT_FOLDER/rc
echo "LOCATION_NAME: $PROJECT_LOCATION" 	>> $PROJECT_FOLDER/rc
echo "MAPSET: $PROJECT_MAPSET" 						>> $PROJECT_FOLDER/rc
echo "GUI: text" 														>> $PROJECT_FOLDER/rc
tar -xzf $PROJECT_FOLDER/grassDB.tar.gz -C $PROJECT_FOLDER/gdb


#####################################################
echo "-- importing data..."
#####################################################
r.in.gdal input=$SOURCES_FOLDER/sjc-wv2-3200x2400-regiao1.tif output=sjc-wv2-3200x2400-regiao1

r.in.gdal location=landsat_loc input=$SOURCES_FOLDER/LC82180762015195LGN00_B1.TIF output=LC82180762015195LGN00_B1
sed -i s/$PROJECT_LOCATION/landsat_loc/ $PROJECT_FOLDER/rc
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B2.TIF output=LC82180762015195LGN00_B2
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B3.TIF output=LC82180762015195LGN00_B3
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B4.TIF output=LC82180762015195LGN00_B4
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B5.TIF output=LC82180762015195LGN00_B5
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B6.TIF output=LC82180762015195LGN00_B6
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B7.TIF output=LC82180762015195LGN00_B7
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B8.TIF output=LC82180762015195LGN00_B8
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B9.TIF output=LC82180762015195LGN00_B9
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B10.TIF output=LC82180762015195LGN00_B10
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_B11.TIF output=LC82180762015195LGN00_B11
r.in.gdal input=$SOURCES_FOLDER/LC82180762015195LGN00_BQA.TIF output=LC82180762015195LGN00_BQA

r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B1.TIF output=LC82190762014039LGN00_B1
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B2.TIF output=LC82190762014039LGN00_B2
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B3.TIF output=LC82190762014039LGN00_B3
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B4.TIF output=LC82190762014039LGN00_B4
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B5.TIF output=LC82190762014039LGN00_B5
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B6.TIF output=LC82190762014039LGN00_B6
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B7.TIF output=LC82190762014039LGN00_B7
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B8.TIF output=LC82190762014039LGN00_B8
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B9.TIF output=LC82190762014039LGN00_B9
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B10.TIF output=LC82190762014039LGN00_B10
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_B11.TIF output=LC82190762014039LGN00_B11
r.in.gdal input=$SOURCES_FOLDER/LC82190762014039LGN00_BQA.TIF output=LC82190762014039LGN00_BQA

r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B1.TIF output=LC82190762014215LGN00_B1
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B2.TIF output=LC82190762014215LGN00_B2
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B3.TIF output=LC82190762014215LGN00_B3
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B4.TIF output=LC82190762014215LGN00_B4
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B5.TIF output=LC82190762014215LGN00_B5
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B6.TIF output=LC82190762014215LGN00_B6
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B7.TIF output=LC82190762014215LGN00_B7
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B8.TIF output=LC82190762014215LGN00_B8
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B9.TIF output=LC82190762014215LGN00_B9
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B10.TIF output=LC82190762014215LGN00_B10
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_B11.TIF output=LC82190762014215LGN00_B11
r.in.gdal input=$SOURCES_FOLDER/LC82190762014215LGN00_BQA.TIF output=LC82190762014215LGN00_BQA


sed -i s/landsat_loc/$PROJECT_LOCATION/ $PROJECT_FOLDER/rc

#####################################################
echo "-- re-projecting..."
#####################################################
# NOTE: use g.region to change extent of destination
r.proj input=LC82180762015195LGN00_B1 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B1 method=nearest
r.proj input=LC82180762015195LGN00_B2 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B2 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B3 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B3 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B4 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B4 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B5 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B5 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B6 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B6 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B7 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B7 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B8 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B8 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B9 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B9 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B10 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B10 method=nearest --quiet
r.proj input=LC82180762015195LGN00_B11 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_B11 method=nearest --quiet
r.proj input=LC82180762015195LGN00_BQA location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82180762015195LGN00_BQA method=nearest --quiet

r.proj input=LC82190762014039LGN00_B1 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B1 method=nearest
r.proj input=LC82190762014039LGN00_B2 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B2 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B3 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B3 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B4 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B4 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B5 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B5 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B6 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B6 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B7 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B7 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B8 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B8 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B9 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B9 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B10 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B10 method=nearest --quiet
r.proj input=LC82190762014039LGN00_B11 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_B11 method=nearest --quiet
r.proj input=LC82190762014039LGN00_BQA location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014039LGN00_BQA method=nearest --quiet

r.proj input=LC82190762014215LGN00_B1 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B1 method=nearest
r.proj input=LC82190762014215LGN00_B2 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B2 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B3 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B3 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B4 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B4 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B5 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B5 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B6 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B6 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B7 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B7 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B8 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B8 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B9 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B9 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B10 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B10 method=nearest --quiet
r.proj input=LC82190762014215LGN00_B11 location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_B11 method=nearest --quiet
r.proj input=LC82190762014215LGN00_BQA location=landsat_loc dbase=$PROJECT_FOLDER/gdb output=LC82190762014215LGN00_BQA method=nearest --quiet



















#####################################################
#echo " 1 - PRE-PROCESSING"
#####################################################
#Correção radiométrica
#Correção Geométrica
#Registro


#i.colors.enhance -f red=landsat.red@PERMANENT green=landsat.green@PERMANENT blue=landsat.blue@PERMANENT



#####################################################
#echo " 2 - ENHANCING"
#####################################################
#Contraste
#Filtragem
#IHS, Componentes principais
#Operações aritméticas


#####################################################
#echo " 2 - ANALYSIS"
#####################################################
#Segmentação
#Classificação
#Mapas
#Representação gráfica
#Propriedades do objeto






echo "-- final cleaning..."
