Sat Mar 26 02:32:44 EDT 2022
#!/bin/bash -l
export JOBID=12346

module load python
module load gcc/9.3.0-gcc-7.5.0 openmpi/4.0.5-gcc-9.3.0 netcdf-c/4.8.0-gcc-9.3.0-openmpi
module load hdf5/1.10.7-gcc-9.3.0-openmpi 
module load netcdf-fortran/4.5.3-gcc-9.3.0-openmpi 
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_NFCONFIG=nf-config
export ESMF_DIR=/home/mpotts/gfortran_9.3.0_openmpi_g_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
chmod +x runpython.sh
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

