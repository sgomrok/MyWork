#!/bin/bash

subdirs=$(find "." -mindepth 1 -maxdepth 1 -type d)
#echo $subdirs 

for d in $subdirs
do
	name=$(basename $d)
	echo $d
	cd $d
	~/git/rinrus2022/bin/probe -unformated -MC -self "all" ${name}_aln.pdb > ${name}_aln.probe
	python3 ~/git/rinrus2022/bin/probe2rins.py -f ${name}_aln.probe -s A:293,A:294
	count=`wc -l < freq_per_res.dat`
	python3 ~/git/rinrus2022/bin/rinrus_trim2_pdb.py -s A:293,A:294 -pdb ${name}_aln.pdb -c res_atoms.dat -model $count
	sed s/25/$count/g ../log.pml > log.pml
	pymol -qc log.pml
	python3 ~/git/rinrus2022/bin/write_input.py -noh res_${count}.pdb -adh res_${count}_h.pdb -intmp ../initial_temp -c 1 -format gaussian
	ls 
	echo "----------------------------------------------------------------"
	echo "----------------------------------------------------------------"
	cd ..
done
