Sun Mar 6 03:54:23 GMT 2022
#!/bin/sh -l
#SBATCH --account=hfv3gfs
#SBATCH -o build-intel_2020.2_mvapich2_g.bat_%j.o
#SBATCH -e build-intel_2020.2_mvapich2_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=xjet
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
export ESMF_MPIRUN=mpirun.srun
export LIBRARY_PATH=$LIBRARY_PATH:/apps/mvapich2/2.3-intel/lib
export ESMF_CXXCOMPILEOPTS="-I/apps/mvapich2/2.3-intel/include"
export ESMF_F90COMPILEOPTS="-I/apps/mvapich2/2.3-intel/include"
module load intel/2020.2 mvapich2/2.3 netcdf/4.7.0
module load hdf5/1.10.6 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/mnt/lfs4/HFIP/hfv3gfs/Mark.Potts/intel_2020.2_mvapich2_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mvapich2
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 24 2>&1| tee build_$JOBID.log

