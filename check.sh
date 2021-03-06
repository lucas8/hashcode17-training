#!/bin/sh

g++ -Wall -Wextra -o -std=c++11 $1 $1.cpp
g++ -Wall -Wextra -o -std=c++11 checker checker.cpp

for i in *.in; do
    echo $i
    ls sols/${i%.in}* | sed 's/sols\/[^\.]*\.\([^\.]*\)\.[^\.]*/\1/' | sort -n | tail -1
    ./$1 < $i > ${i%.in}.$1.out
    if ./checker $i ${i%.in}.$1.out; then
        score=$(./checker $i ${i%.in}.$1.out)
        mv ${i%.in}.$1.out sols/${i%.in}.${score% }.out
    fi
done;
