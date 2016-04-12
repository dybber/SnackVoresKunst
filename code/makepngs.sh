#!/bin/sh
for i in *.pdf; do convert $i -background white -alpha remove `basename $i .pdf`.png; done
