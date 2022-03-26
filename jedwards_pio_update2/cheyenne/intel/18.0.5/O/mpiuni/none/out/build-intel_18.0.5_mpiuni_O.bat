Sat Mar 26 00:48:23 MDT 2022
#!/bin/sh -l
#PBS -N build-intel_18.0.5_mpiuni_O.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/rlong/esmf-testing/intel_18.0.5_mpiuni_O_jedwards_pio_update2

module load python
export ESMF_MPIRUN=/glade/scratch/rlong/esmf-testing/intel_18.0.5_mpiuni_O_jedwards_pio_update2/src/Infrastructure/stubs/mpiuni/mpirun
module load intel/18.0.5  netcdf/4.6.3
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/rlong/esmf-testing/intel_18.0.5_mpiuni_O_jedwards_pio_update2
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

