Sun Mar 20 01:35:54 EDT 2022
#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o build-pgi_2020_mpiuni_O.bat_%j.o
#SBATCH -e build-pgi_2020_mpiuni_O.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load comp/pgi/20.4  

module list >& module-build.log

set -x

export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/pgi_2020_mpiuni_O_jedwards_pio_update2
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 28 2>&1| tee build_$JOBID.log

