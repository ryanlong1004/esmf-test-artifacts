Sat Mar 26 07:14:40 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-pgi_18.1_intelmpi_O.bat_%j.o
#SBATCH -e build-pgi_18.1_intelmpi_O.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
export ESMF_MPIRUN=mpirun.srun
module load pgi/18.10 impi/2018.0.4 

module list >& module-build.log

set -x

export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/pgi_18.1_intelmpi_O_jedwards_pio_update2
export ESMF_COMPILER=pgi
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

