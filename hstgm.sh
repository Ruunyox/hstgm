#! /bin/bash

data=`cat $1`

cols=$(( $(tput cols) ))
max=$( echo "${data}" | awk -F '\t' -v max=0 'NR>2 {if($2>max) max=$2;}END{print max;}' )
str=$( echo "${data}" | awk -F '\t' -v str=0 'NR>2 {if(length($1)>str) str=length($1);}END{print str;}' )
printf "\n"
echo "${data}" | awk -F '\t' -v cols=${cols} -v max=${max} -v str=${str}\
				'NR==1 {printf "%s:\n\n",$0} \
				NR>2 {number=$2;printf "%-*s | ",str+1,$1;\
				for (i=0;i<int(0.4*cols*number/max);i++) 
					if (NR%2 == 0){printf "\033[30;42m \033[0m";} 
					else {printf "\033[30;47m \033[0m";} 
				printf " %s\n",$2}' 
printf "\n"

