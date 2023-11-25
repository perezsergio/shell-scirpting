#!/bin/bash

# #!(..) determines what executes the file
# for example here ./file -> /bin/bash file

#This script displays various information to the screen

#Display 'Hello'
echo 'hello'

#Asign value to variable
WORD='someWord' # No space around the equal sign

echo "$WORD"                                                  #echoes the value stored in the variable WORD
echo '$WORD'                                                  #echoes the literal string '$SWRORD'
echo "This combines hard-coded text with a variable ${WORD} " #best-practice
echo "This combines hard-coded text with a variable $WORD "   #alternative
