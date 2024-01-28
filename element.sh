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

# Check element if retrievable using atomic number
GET_ELEMENT_ATOMIC_NUMBER() {
  echo "get element by number"
}

# Check element if retrievable using atomic symbol
GET_ELEMENT_SYMBOL() {
  echo "get element by symbol"
}

# Check element if retrievable using atomic name
GET_ELEMENT_NAME() {
  echo "get element by name"
}

# Format the extracted data and output it
OUTPUT() {
  echo "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME. It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
}

# If not found
NOT_FOUND() {
  echo "not found"
}

# Extract data from returned data and extract to variables
GET_DETAILS() {
  GET_DETAILS=($(echo "$1" | awk '{ print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13 }'))
  
  ATOMIC_NUMBER="${values[0]}"
  ATOMIC_MASS="${values[2]}"
  MELTING_POINT="${values[4]}"
  BOILING_POINT="${values[6]}"
  SYMBOL="${values[8]}"
  ELEMENT_NAME="${values[10]}"
  TYPE="${values[12]}"
}

# START
CHECK_INPUT $1