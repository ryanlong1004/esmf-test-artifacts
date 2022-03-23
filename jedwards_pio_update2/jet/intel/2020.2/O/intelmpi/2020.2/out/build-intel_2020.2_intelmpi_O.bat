Wed Mar 23 03:55:18 GMT 2022
#!/bin/sh -l
#SBATCH --account=hfv3gfs
#SBATCH -o build-intel_2020.2_intelmpi_O.bat_%j.o
#SBATCH -e build-intel_2020.2_intelmpi_O.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=xjet
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
module load intel/2020.2 impi/2020.2 netcdf/4.7.0
module load hdf5/1.10.6 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/mnt/lfs4/HFIP/hfv3gfs/Mark.Potts/intel_2020.2_intelmpi_O_jedwards_pio_update2
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 24 2>&1| tee build_$JOBID.log

