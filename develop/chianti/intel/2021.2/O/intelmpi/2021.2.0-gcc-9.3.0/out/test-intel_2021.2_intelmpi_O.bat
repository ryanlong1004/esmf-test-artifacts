Sun Mar 27 02:25:24 EDT 2022
#!/bin/bash -l
export JOBID=12346
module load intel-oneapi-compilers/2021.2.0-gcc-9.3.0 intel-oneapi-mpi/2021.2.0-gcc-9.3.0 netcdf-c/4.8.0-intel-2021.2.0
module load netcdf-fortran/4.5.3-intel-2021.2.0 
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/home/mpotts/intel_2021.2_intelmpi_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
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

