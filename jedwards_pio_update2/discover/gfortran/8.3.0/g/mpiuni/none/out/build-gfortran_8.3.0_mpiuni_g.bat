Tue Mar 8 01:25:45 EST 2022
#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o build-gfortran_8.3.0_mpiuni_g.bat_%j.o
#SBATCH -e build-gfortran_8.3.0_mpiuni_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load comp/gcc/8.3.0  

module list >& module-build.log

set -x

export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/gfortran_8.3.0_mpiuni_g_jedwards_pio_update2
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 28 2>&1| tee build_$JOBID.log

