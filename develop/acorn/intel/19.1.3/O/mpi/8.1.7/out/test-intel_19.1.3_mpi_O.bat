Fri 18 Mar 01:31:39 UTC 2022
#!/bin/sh -l
#PBS -N test-intel_19.1.3_mpi_O.bat
#PBS -l walltime=1:00:00
#PBS -q dev
#PBS -A GFS-DEV
#PBS -l select=1:ncpus=128:mpiprocs=128
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /lfs/h1/emc/ptmp/Mark.Potts/intel_19.1.3_mpi_O_develop

module unload PrgEnv-cray PrgEnv-gnu

module load PrgEnv-intel cray-pals craype cmake
module load intel/19.1.3.304 cray-mpich/8.1.7 netcdf/4.7.4
module load hdf5/1.10.6 
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_MPIRUN=mpirun.unicos
export ESMF_CXXCOMPILECPPFLAGS=-fPIC
export ESMF_CXXLINKOPTS="-fPIC -lnetcdff -lnetcdff"
export ESMF_NETCDF=nc-config
sed -i 's/^aprun/mpiexec/' scripts/mpirun.unicos
sed -i 's/lmpi++/lfmpich/' build_config/Linux.intel.default/build_rules.mk
export ESMF_DIR=/lfs/h1/emc/ptmp/Mark.Potts/intel_19.1.3_mpi_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
chmod +x runpython.sh
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 


cd ../src/addon/ESMPy

export PATH=$PATH:$HOME/.local/bin
python3 setup.py build 2>&1 | tee python_build.log
ssh alogin01 /lfs/h1/emc/ptmp/Mark.Potts/intel_19.1.3_mpi_O_develop/runpython.sh 2>&1 | tee python_build.log
python3 setup.py test 2>&1 | tee python_test.log
python3 setup.py test_examples 2>&1 | tee python_examples.log
python3 setup.py test_regrid_from_file 2>&1 | tee python_regrid.log
