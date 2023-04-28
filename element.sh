#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
  echo -e "Please provide an element as an argument."
else
  #Check if element exists in table?
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    CHECK_ELEMENT_IN_DB=$($PSQL "SELECT name, atomic_mass, melting_point_celsius, boiling_point_celsius, type, symbol, atomic_number FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number='$1'")
  elif [[ $1 =~ ^[a-zA-Z]{,2}$ ]]
  then
    CHECK_ELEMENT_IN_DB=$($PSQL "SELECT name, atomic_mass, melting_point_celsius, boiling_point_celsius, type, symbol, atomic_number FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$1'")
  else
    CHECK_ELEMENT_IN_DB=$($PSQL "SELECT name, atomic_mass, melting_point_celsius, boiling_point_celsius, type, symbol, atomic_number FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name='$1'")
  fi
  #If no - print error
  if [[ -z $CHECK_ELEMENT_IN_DB ]]
  then
    echo -e "I could not find that element in the database."
  #If yes - print a details about element
  else
    #echo $CHECK_ELEMENT_IN_DB
    
    ELEMENT_NAME=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 1)
    ELEMENT_MASS=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 2)
    ELEMENT_MELTING_POINT=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 3)
    ELEMENT_BOILING_POINT=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 4)
    ELEMENT_TYPE=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 5)
    ELEMENT_SYMBOL=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 6)
    ELEMENT_NUMBER=$(echo $CHECK_ELEMENT_IN_DB | cut -d "|" -f 7)
    echo -e "The element with atomic number $ELEMENT_NUMBER is $ELEMENT_NAME ($ELEMENT_SYMBOL). It's a $ELEMENT_TYPE, with a mass of $ELEMENT_MASS amu. $ELEMENT_NAME has a melting point of $ELEMENT_MELTING_POINT celsius and a boiling point of $ELEMENT_BOILING_POINT celsius."
  fi
fi