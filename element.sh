#! /bin/bash

echo 'Please provide an element as an argument'

# Check input if atomic number, symbol or element name
CHECK_INPUT() {
  echo "check input"
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
CHECK_INPUT