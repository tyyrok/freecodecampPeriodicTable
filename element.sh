#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo -e "\nPlease provide an element as an argument."
else
  #Check if element exists in table?
  CHECK_ELEMENT_IN_DB=$($PSQL "SELECT name FROM elements WHERE atomic_number='$1' OR symbol='$1'")
  #If no - print error
  if [[ -z $CHECK_ELEMENT_IN_DB ]]
  then
    echo -e "\nI could not find that element in the database."
  #If yes - print a details about element
  else
    echo -e "\nBingo!"
  fi
fi