#!/usr/bin/env bash
read -p "INPUT A NUMBER: " n
 #for n in {0..9}
  # do
#   if [[ $n -eq {0..9} ]]; then echo "Enter a value between 1 - 9"
      if [[ $n = 0 ]]; then
         var=zero
           echo $var 
 elif [[ $n = 1 ]]; then 
     var=one
  echo $var
        elif [[ $n = 2 ]]; then
  var=two
   echo $var 
         elif [[ $n = "3" ]]; then
   var=three
   echo $var
          elif [[ $n = "4" ]]; then
  var=four
   echo $var
         elif [[ $n = "5" ]]; then
  var=five 
   echo $var
        elif [[ $n = "6" ]]; then
  var=six 
   echo $var
       elif [[ $n = "7" ]]; then
  var=seven
   echo $var
      elif [[ $n = "8" ]]; then
  var=eight
   echo $var
     elif [[ $n = "9" ]]; then
  var=nine 
   echo $var
else 
   echo "Number above range"
 exit 3
     fi
 
