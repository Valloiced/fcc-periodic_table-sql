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

# If not found
NOT_FOUND() {
  echo "not found"
}

# START
CHECK_INPUT $1