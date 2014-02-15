#!/bin/bash

cmove () {          #this moves its argument to the old directory
    mv $1 ./old
}

cmkdir () {         #this makes a directory if it doesn't exist          
    if [[ ! -d $1 ]]
    then
	mkdir $1
    fi
}
#these are usually junk files
rm *~  
rm *#

cmkdir ./compiled

#moves compiled files to the compiled directory
mv *.o ./compiled
mv *.hi ./compiled
cmkdir ./old
cmkdir ./old/haskell
cmkdir ./old/c

#this calls cmore on all the old files in the directory
for i in $( find ./ -maxdepth 1 -type f -atime +5 )
do
    cmove $i
done

#move files to the directory of their respective languages
mv ./old/*.hs ./old/haskell
mv ./old/*.c ./old/c
clear