Sat Mar 26 03:05:36 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-gfortran_9.2.0_openmpi_O.bat_%j.o
#SBATCH -e build-gfortran_9.2.0_openmpi_O.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
export ESMF_MPIRUN=mpirun.srun
module load gnu/9.2.0 openmpi/3.1.4 netcdf-hdf5parallel/4.7.4
module load hdf5/1.10.5 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=split
export ESMF_NETCDF_INCLUDE=$NETCDF/include
export ESMF_NETCDF_LIBPATH=$NETCDF/lib
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5 $HDF5ExtraLibs"
export ESMF_NETCDF=nc-config
tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/gfortran_9.2.0_openmpi_O_jedwards_pio_update2
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

