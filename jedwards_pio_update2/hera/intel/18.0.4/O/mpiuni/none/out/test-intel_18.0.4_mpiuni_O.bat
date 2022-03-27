Sun Mar 27 05:51:25 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o test-intel_18.0.4_mpiuni_O.bat_%j.o
#SBATCH -e test-intel_18.0.4_mpiuni_O.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
module load intel/18.0.5.274  netcdf-hdf5parallel/4.7.4
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/intel_18.0.4_mpiuni_O_jedwards_pio_update2
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

