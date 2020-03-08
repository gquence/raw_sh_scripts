#!/bin/sh
# usage sh files_disk_usage_dir.sh [dir]
# 
# This script was made for searching of TOP 5 heaviest files in [dir] and applying command (in line 32)
#          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#          !!!!!!!! ATTENTION TO THE LINE 32 !!!!!!!!!!
#          !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


# $1 (first argument)	is primary directory (start for searching)
get_files_diskusage()
{
	for i in $(find $1 -type f)
	do
		du $i 
	done
	return 0
}


if [ -n "$1" ]
then
	cur_dir=$1
else
	cur_dir="."
fi
list_of_files=$(get_files_diskusage $cur_dir | sort -nr | head -5 | tr '\n' ',\n')

echo "Found files for removing:"
echo -n $list_of_files | tr ',' '\n' | sed 's/ / Kb used by /g' # OUTPUT TOP-5 HEAVIEST FILES INFO

cmd_rm="cat " # YOU NEED TO CHANGE TO "rm" OR TO THE NECESSARY COMMAND
list_for_rm=$(echo $list_of_files | tr ',' '\n' | cut -d' ' -f2 | tr '\n' ' ')
cmd_rm="$cmd_rm $list_for_rm"
# construction of command is done

# file delete request
for i in $(seq 1 3);
do 
	read -p "Do you want to continue? [Y/n] " ans;
	case $ans in
		"N" | "n")
		  echo "Abort."
		  exit 1
		  ;;
		"Y" | "y")
		  echo $cmd_rm
		  $cmd_rm
		  exit 0
		  ;;
		*)
		  echo "wrong literal"
		  ;;
	esac
done

