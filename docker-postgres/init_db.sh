#!/bin/bash

# this script is runned when the docker container is built
# it imports the base database structure and create the database for the tests

DATABASE_NAME="dpa"
DB_DUMP_LOCATION="/tmp/psql_data/iris.sql"

echo "*** CREATING DATABASE ***"

# create default database
# gosu postgres postgres --single <<EOSQL
psql --username postgres <<EOSQL
  CREATE DATABASE "$DATABASE_NAME";
  GRANT ALL PRIVILEGES ON DATABASE "$DATABASE_NAME" TO postgres;
EOSQL

echo "1"

# clean sql_dump - because I want to have a one-line command

# remove indentation
sed "s/^[ \t]*//" -i "$DB_DUMP_LOCATION"

# remove comments
sed '/^--/ d' -i "$DB_DUMP_LOCATION"

# remove new lines
sed ':a;N;$!ba;s/\n/ /g' -i "$DB_DUMP_LOCATION"

# remove other spaces
sed 's/  */ /g' -i "$DB_DUMP_LOCATION"

# remove firsts line spaces
sed 's/^ *//' -i "$DB_DUMP_LOCATION"

# append new line at the end (suggested by @Nicola Ferraro)
sed -e '$a\' -i "$DB_DUMP_LOCATION"

echo "2"

# import sql_dump
psql --username postgres "$DATABASE_NAME" < "$DB_DUMP_LOCATION";


echo "*** DATABASE CREATED! ***"