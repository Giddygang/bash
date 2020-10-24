#!/usr/bin/env bash
read -p "INPUT A STRING VALUE: " str
 array=($str)
function string(){ 
     read -p "INPUT YOUR NEEDED STRING NUMBER: " num
            echo ${array[0]:$num:1}
               lengh=${#str}
               d=$(($lengh-1))
                  echo $d
}
                                                               string
 function countBs(){
       read -p "INPUT ANOTHER STRING: " var
         for B in [$var]
          do
             char="$var"
            res="${char//[^B]}"
              echo  "${#res}"
          done
}
                                                               countBs
 function countchar(){
        read -p "INPUT A STRING: " val
         echo "THE CHARACTER TO CHEECKED FOR IS A"
          for A in [$val]
           do
             hen="$val"
               fel="${hen//[^A]}"
            echo  "${#fel}"
              exit 2
                 done
 }
                                                                countchar
