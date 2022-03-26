Sat Mar 26 02:45:54 PDT 2022
#!/bin/sh -l
#SBATCH --account=e3sm
#SBATCH -o test-intel_19.0.3_mpiuni_O.bat_%j.o
#SBATCH -e test-intel_19.0.3_mpiuni_O.bat_%j.e
#SBATCH --time=3:00:00
#SBATCH -C haswell
#SBATCH --qos=regular
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=32
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module unload darshan
module load intel/19.0.3.199  cray-netcdf/4.6.3.2
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF_LIBS="-lnetcdf"
export ESMF_NETCDFF_LIBS="-lnetcdff"
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/opt/cray/pe/hdf5/1.10.5.2/INTEL/19.0/lib/pkgconfig
export ESMF_DIR=/global/cscratch1/sd/rsdunlap/esmf-testing/intel_19.0.3_mpiuni_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
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

