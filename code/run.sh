#!/bin/sh
mkdir -p gen
java -Djava.ext.dirs=/home/dybber/lib/processing-2.2.1/core/library/:/home/dybber/lib/processing-2.2.1/modes/java/libraries/pdf/library/ -cp $PWD/build snackvoreskunst_sketch $@
