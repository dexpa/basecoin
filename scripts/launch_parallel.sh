#/bin/bash

seq 10 | xargs -n 1 -P 1 bash send_parallel.sh ${1}
