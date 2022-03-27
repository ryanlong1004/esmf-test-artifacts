Sun Mar 27 06:04:22 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-intel_18.0.4_mpiuni_g.bat_%j.o
#SBATCH -e build-intel_18.0.4_mpiuni_g.bat_%j.e
#SBATCH --time=2:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
export ESMF_MPIRUN=/scratch1/NCEPDEV/stmp2/role.esmfmaint/intel_18.0.4_mpiuni_g_develop/src/Infrastructure/stubs/mpiuni/mpirun
module load intel/18.0.5.274  netcdf-hdf5parallel/4.7.4
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/intel_18.0.4_mpiuni_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

