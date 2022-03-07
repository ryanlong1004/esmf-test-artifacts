Mon 07 Mar 2022 01:29:42 AM UTC
#!/bin/sh -l
#PBS -N build-gfortran_10.3.0_mpich3_O.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=1:00:00
#PBS -q dev
#PBS -A GFS-DEV
#PBS -l select=1:ncpus=128:mpiprocs=128
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /lfs/h1/emc/ptmp/Mark.Potts/gfortran_10.3.0_mpich3_O_jedwards_pio_update2

module unload PrgEnv-cray PrgEnv-intel

module load PrgEnv-gnu cray-pals craype
module load gcc/10.3.0 cray-mpich/8.1.7 netcdf
module load hdf5 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_OS=Linux
export ESMF_CXXCOMPILER=CC
export ESMF_F90COMPILER=ftn
export ESMF_CXXLINKER=CC
export ESMF_F90LINKER=ftn
export ESMF_MPIRUN=mpirun.unicos
export ESMF_F90COMPILEOPTS="-fallow-argument-mismatch -fallow-invalid-boz"
export ESMF_NFCONFIG=nf-config
export ESMF_CXXLINKOPTS="-fPIC -lnetcdff -lnetcdff"
sed -i 's/aprun/mpiexec/' scripts/mpirun.unicos
export ESMF_DIR=/lfs/h1/emc/ptmp/Mark.Potts/gfortran_10.3.0_mpich3_O_jedwards_pio_update2
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpich3
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 128 2>&1| tee build_$JOBID.log

