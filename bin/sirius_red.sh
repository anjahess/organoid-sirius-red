#!/bin/bash
########### SCRIPT FOR SR-IMAGE-J MACRO on all subfolders of a directory ################
#           ALIAS: siriusred='bash sirius_red.sh'
#           USAGE: siriusred -macro_name -directory_to_apply_to
#           for whole slide:
#           siriusred all_folder_sirius_red_quanti_200um_scaled .
#           for organoid ROIs:
#           siriusred all_folder_rectangle_selection .
#           siriusred all_folder_sirius_red_quanti_300um_squares .

# The Sirius red quantification module was adopted from the NIH-Image J macro
# “Quantifying Stained Liver Tissue“
# available at https://imagej.nih.gov/ij/docs/examples/stained-sections/index.html, requested 2020-11-14

### Step 0: Select directories:
bash_path="../"
makro_path=$bash_path"ij_scripts/"

### Step 1: Make subdirectories and run the script.
imagej_path=$1
script=$2
img_dir=$(echo "$3")
light_factor=$4 # add light to the end of command ev.

if [ -z "$light_factor" ]
then
    light_factor = 1.3  # light stainings change to ~ 0.95, YOU MUST USE THE SAME THRESH FOR CONTROLS AND TREATMENTS!
fi

echo ""
echo "-----------------------------------------------------------------------------"
echo "             S I R I U S   R E D   Q U A N T I F I C A T I O N"
echo "                        I N      O R G A N O I D S          "
echo ""
echo "-- ImageJ:" $imagej_path
echo "-- Script:" $makro_path$script.ijm
echo "-- Light factor:" $light_factor
echo "-- Your images:" $img_dir
echo "-----------------------------------------------------------------------------"
echo ""

eval cd "$img_dir"
for folder in "$search_dir" *

##### 1. INITIALLY GENERATE FOLDER STRUCTURE ONCE
do
  if [[ "$folder" == "" ]] || [[ ! -d $folder ]]; then
  	continue
  elif [[ -d $folder ]]; then

    echo "-- Found sample: "$folder

    # CREATE INPUT FOLDERS
    [ -d $folder/input/whole_slide ] || mkdir -p $folder/input/whole_slide
    [ -d $folder/input/organoid_ROIs ] || mkdir -p $folder/input/organoid_ROIs

  	# RESULTS FOLDERS
  	[ -d $folder/results/ ] || mkdir $folder/results/
  	[ -d $folder/results/whole_slide ] || mkdir $folder/results/whole_slide
  	[ -d $folder/results/organoid_ROIs ] || mkdir $folder/results/organoid_ROIs
  fi
done

##### 2. NOW THAT FOLDER STRUCTURE IS BUILT, ANALYSE
for folder in "$search_dir" *
do
  if [[ "$folder" == "" ]] || [[ $folder =~ "results" ]]; then
  	continue
  else
  	folder_string="$folder"
  	folder_string=$(echo "${folder_string//'\'}")
    dir=$(readlink -f $folder_string)
  	echo "-- Analyzing "$dir
  	$imagej_path"jre/bin/java" -Xmx512m -jar $imagej_path"ij.jar" -ijpath $imagej_path -macro $makro_path$script.ijm "$dir,$light_factor"
  fi
done

echo ""
echo "-----------------------------------------------------------------------------"
echo "Finished analysis"
echo "Results are in" $folder"/results/"
echo "-----------------------------------------------------------------------------"
# END OF SCRIPT