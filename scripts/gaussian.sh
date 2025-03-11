#!/bin/bash 
#SBATCH --cpus-per-task=10
#SBATCH --time=240:00:00
#SBATCH --partition=icomputeq
#SBATCH --mem-per-cpu=12GB

mkdir /scratch/$USER/$SLURM_JOB_ID
export TMPDIR=/scratch/$USER/$SLURM_JOB_ID
echo Working directory is $SLURM_SUBMIT_DIR
echo tmp directory is $TMPDIR
echo env is $ENVIRONMENT
echo Running on host `hostname`
echo Directory is `pwd`
echo job id is $SLURM_JOB_ID

module load gaussian/g16
GAUSS_SCRDIR=$TMPDIR; export GAUSS_SCRDIR
export g16root=/opt/ohpc/pub/apps/uofm/gaussian/g16
. $g16root/g16/bsd/g16.profile
echo which g16 = `which g16`

cd $SLURM_SUBMIT_DIR/
ls -alh
du -k
df -h
hostname

/opt/ohpc/pub/apps/uofm/gaussian/g16/g16 < 1.inp>& 1.out

cd $TMPDIR
ls -alh
du -k
df -h

rm -rf $TMPDIR
