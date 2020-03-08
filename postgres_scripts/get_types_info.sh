# !/bin/sh
# using: sh get_types_info.sh [db_name]
#                                  |   
#                        (by default is "test_db")
# RDBMS - PostgreSQL
# advice: add password of DB in ~/.pgpass

if [ -z $1 ];
then
	db_name="test_db" #default value
else
	db_name=$1
fi

a=$(psql $db_name -c '\dT' | sed 1,3d | grep -v '(*)' | sed '$ d'|  sed 's/ //g' | awk -F '|' -v db_name_awk="$db_name" '{print "psql " db_name_awk " -c \"\\dT+ " $2 "\" && "}')

echo $a | awk '{print substr($0,1,length($0)-3)}' > tmp.sh
chmod +x tmp.sh
sh tmp.sh
rm tmp.sh

