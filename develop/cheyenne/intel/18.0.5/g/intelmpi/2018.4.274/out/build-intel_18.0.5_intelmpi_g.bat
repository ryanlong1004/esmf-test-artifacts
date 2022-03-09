Wed Mar 9 06:29:25 MST 2022
#!/bin/sh -l
#PBS -N build-intel_18.0.5_intelmpi_g.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/rlong/esmf-testing/intel_18.0.5_intelmpi_g_develop
module load intel/18.0.5 impi/2018.4.274 netcdf/4.6.3
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/rlong/esmf-testing/intel_18.0.5_intelmpi_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

