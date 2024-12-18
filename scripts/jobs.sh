#!/bin/bash

if [ -n "$1" ]; then
USER=$1
fi

numbers=( `squeue -u $USER | grep -v 'JOBID' | awk '{print $1}'` )
##numbers=( `squeue -u $USER | grep -v 'JOBID' | cut -d _ -f 1` )
#queues=( `squeue -u $USER | grep -v 'JOBID' | awk '{print $2}'` )
#wtimes=( `squeue -u $USER | grep -v 'JOBID' | awk '{print $6}'` )
#
##263150_[345,347,39
##281913_[1-625%10]
##JobId=281895 JobName=gaussian16.sh
##JobId=272873 ArrayJobId=263150 ArrayTaskId=345 JobName=slurm-array-mrcc-in-molpro.sh
echo ${#numbers[*]} jobs for $USER
#
#for (( i=0;i<${#numbers[@]};i++ ))
#    do
#        #if [[ ${numbers[$i]} == *\%* ]]; then
#        if [[ ${numbers[$i]} == *\%* ]] || [[ ${numbers[$i]} == *\[* ]]; then
#            queinfo=${queues[$i]}
#            cputimes=${wtimes[$i]}
#            printf "%-20s %12s %12s %12s\n" ${numbers[$i]} 'PENDING' ${queinfo} ${cputimes}
#        else
#            #cputimes=( `scontrol show job ${numbers[$i]} | grep "RunTime" | awk '{print $1}'` )
#            #jobstatus=( `scontrol show job ${numbers[$i]} | grep "JobState" | awk '{print $1}'` )
#            #directories=( `scontrol show job ${numbers[$i]} | grep "WorkDir" | awk '{print $1}'` )
#            #numinfo=( `scontrol show job ${numbers[$i]} | grep "ArrayTaskId" | awk -F'=' '{print $2}'` )
#            queinfo=( `scontrol show job ${numbers[$i]} | grep "Partition" | awk -F'=' '{print $2}'` )
#            cputimes=( `scontrol show job ${numbers[$i]} | grep "RunTime" | awk -F'=' '{print $2}'` )
#            walltimes=( `scontrol show job ${numbers[$i]} | grep "TimeLimit" | awk '{print $2}' | awk -F'=' '{print $2}'` )
#            jobstatus=( `scontrol show job ${numbers[$i]} | grep "JobState" | awk -F'=' '{print $2}'` )
#            directories=( `scontrol show job ${numbers[$i]} | grep "WorkDir" | awk -F'=' '{print $2}'` )
#            printf "%-20s %12s %12s %12s %12s    %s\n" ${numbers[$i]} ${jobstatus} ${queinfo} ${cputimes} ${walltimes} ${directories}
#        fi
#    done

#numbers=( `sacct --state=running,pending,suspended -u $USER -X | wc -l ` )
#echo $numbers jobs for $USER
sacct --state=R,PD -u $USER -X --format state%8,partition%8,elapsed%12,timelimit%12,jobid%-10,workdir%-105
#sacct --state=running,pending,suspended -u $USER -X --format state%8,partition%8,elapsed%12,timelimit%12,jobid%-10,workdir%-85
#sacct --state=running,pending -u $USER --format "state,partition,elapsed,timelimit,jobid,workdir%125"
### sacct -o MaxRSS -j jobid        to check memory used for job
