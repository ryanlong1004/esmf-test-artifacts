Sat Mar 26 06:02:57 MDT 2022
#!/bin/sh -l
#PBS -N build-intel_18.0.5_module_g.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/rlong/esmf-testing/intel_18.0.5_module_g_develop

module load python
export ESMF_MPIRUN=/glade/scratch/rlong/esmf-testing/intel_18.0.5_module_g_develop/src/Infrastructure/stubs/mpiuni/mpirun
module load intel/18.0.5  netcdf/4.6.3
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/rlong/esmf-testing/intel_18.0.5_module_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=module
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

