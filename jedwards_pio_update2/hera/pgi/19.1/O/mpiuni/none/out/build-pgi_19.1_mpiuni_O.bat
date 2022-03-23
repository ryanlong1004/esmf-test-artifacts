Wed Mar 23 22:25:00 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-pgi_19.1_mpiuni_O.bat_%j.o
#SBATCH -e build-pgi_19.1_mpiuni_O.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
module load pgi/19.10  

module list >& module-build.log

set -x

export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/pgi_19.1_mpiuni_O_jedwards_pio_update2
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

