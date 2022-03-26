Sat Mar 26 06:36:29 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-gfortran_9.2.0b_intelmpi_g.bat_%j.o
#SBATCH -e build-gfortran_9.2.0b_intelmpi_g.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
export ESMF_MPIRUN=mpirun.srun
module load gnu/9.2.0 impi/2020 

module list >& module-build.log

set -x

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/gfortran_9.2.0b_intelmpi_g_jedwards_pio_update2
export ESMF_COMPILER=gfortran
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

