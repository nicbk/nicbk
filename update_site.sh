#!/bin/sh
hugo -D
cd public
git add --all
git commit -a -S
git push origin master
cd ../
git add --all
git commit -a -S
git push origin master
