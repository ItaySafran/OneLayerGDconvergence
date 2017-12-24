#!/bin/csh
#------------------------------
# Run experiment for single parameter combination.
# Parameter 1 is number of target neurons
# Parameter 2 is number of trained neurons
# Parameter 3 is run number
# Parameter 4 is seed for random number generator

/usr/local/bin/matlab2016b -nodesktop -nodisplay -nojvm -r "cd('~/e'); $1, $2, $3, [Wbad,objVals] = run_findBadMinima($1,$2,$4);cd('~/e/results'); save(['exp-$1-$2-$3.mat']);exit;"
