#!/usr/bin/env bash

 function collatz() {
  if (( $number % 2 ))
then
   a=$(($number*3))
   b=$(($a+1))
echo $b
 else
  c=$(($number/2))
  #d=$(($c+1))
   echo $c
 fi
}

 read -p "INPUT AN INTEGER : " number
  REGEX=[:digit:]
if [[ $number =~ $REGET ]]
 then
  collatz
   while [ $b -eq 10 ] || [ $c -ne 1 ]
   do
 break
    done
 else
   echo "Run the program again and Input an Integer"
fi

