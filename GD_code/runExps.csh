#!/bin/csh

set dirpath="~/e/results"

set seed = 10954
set kV = 5
while ( $kV <= 20 )
	set kW = $kV
    set kWTarget = ( $kV + 2 )
    if ( $kWTarget > 20 ) then
        @ kWTarget = 20
    endif
	while ( $kW <= $kWTarget )
        set numRun = 1
        while ( $numRun <= 10 )
            set suffix="$kV-$kW-$numRun"
            rm $dirpath/exp-$suffix.* -f
            qsub -q ohadall.q -N shamiro_$suffix -e $dirpath/exp-$suffix.e -o $dirpath/exp-$suffix.o runExp.csh $kV $kW $numRun $seed
            echo "Running with kV=$kV and kW=$kW, run $numRun"
            @ numRun++
            @ seed++
        end
		@ kW++
	end
	@ kV++
end
