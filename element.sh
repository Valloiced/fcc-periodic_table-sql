#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# Check input if atomic number, symbol or element name
CHECK_INPUT() {
  # If no input 
  if [[ -z $1 ]]
  then 
    echo 'Please provide an element as an argument'
    return
  fi

  # If input is a number
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    GET_ELEMENT_ATOMIC_NUMBER $1
    return
  fi

  # If input is a symbol
  STR_LENGTH=$(echo -n $1 | wc -m)

  if [[ $STR_LENGTH -le 2 && $STR_LENGTH -gt 0 ]]
  then
    GET_ELEMENT_SYMBOL $1
    return
  fi

  # If input is an element name (given)
  GET_ELEMENT_NAME $1
}

# Extract data from returned data and extract to variables
GET_DETAILS() {
  GET_DETAILS=($(echo "$1" | awk '{ print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13 }'))
  
  ATOMIC_NUMBER="${GET_DETAILS[0]}"
  ATOMIC_MASS="${GET_DETAILS[2]}"
  MELTING_POINT="${GET_DETAILS[4]}"
  BOILING_POINT="${GET_DETAILS[6]}"
  SYMBOL="${GET_DETAILS[8]}"
  ELEMENT_NAME="${GET_DETAILS[10]}"
  TYPE="${GET_DETAILS[12]}"
}

# Check element if retrievable using atomic number
GET_ELEMENT_ATOMIC_NUMBER() {
  GET_ELEMENT_RESULT=$(
    $PSQL "
      SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type 
      FROM properties 
      INNER JOIN elements USING(atomic_number)
      INNER JOIN types USING(type_id)
      WHERE atomic_number=$1
    ")

  if [[ -z $GET_ELEMENT_RESULT ]]
  then 
    NOT_FOUND
    return
  fi

  # Extract data
  GET_DETAILS "$GET_ELEMENT_RESULT"

  # Output data
  OUTPUT
}

# Check element if retrievable using atomic symbol
GET_ELEMENT_SYMBOL() {
  GET_ELEMENT_RESULT=$(
    $PSQL "
      SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type 
      FROM properties 
      INNER JOIN elements USING(atomic_number)
      INNER JOIN types USING(type_id)
      WHERE symbol='$1'
    ")

  if [[ -z $GET_ELEMENT_RESULT ]]
  then 
    NOT_FOUND
    return
  fi

  # Extract data
  GET_DETAILS "$GET_ELEMENT_RESULT"

  # Output data
  OUTPUT
}

# Check element if retrievable using atomic name
GET_ELEMENT_NAME() {
  GET_ELEMENT_RESULT=$(
    $PSQL "
      SELECT atomic_number, atomic_mass, melting_point_celsius, boiling_point_celsius, symbol, name, type 
      FROM properties 
      INNER JOIN elements USING(atomic_number)
      INNER JOIN types USING(type_id)
      WHERE name='$1'
    ")

  if [[ -z $GET_ELEMENT_RESULT ]]
  then 
    NOT_FOUND
    return
  fi

  # Extract data
  GET_DETAILS "$GET_ELEMENT_RESULT"

  # Output data
  OUTPUT
}

# Format the extracted data and output it
OUTPUT() {
  echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME. It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
}

# If not found
NOT_FOUND() {
  echo "I could not find that element in the database."
}

# START
CHECK_INPUT $1