Fri Mar 18 03:53:53 GMT 2022
#!/bin/sh -l
#SBATCH --account=hfv3gfs
#SBATCH -o build-gfortran_9.2.0_openmpi_g.bat_%j.o
#SBATCH -e build-gfortran_9.2.0_openmpi_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=xjet
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5"
module load gnu/9.2.0 openmpi/3.1.4 netcdf/4.7.2
module load hdf5/1.10.5 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/mnt/lfs4/HFIP/hfv3gfs/Mark.Potts/gfortran_9.2.0_openmpi_g_jedwards_pio_update2
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 24 2>&1| tee build_$JOBID.log

#!/bin/sh -l
#SBATCH --account=hfv3gfs
#SBATCH -o build-gfortran_9.2.0_openmpi_g.bat_%j.o
#SBATCH -e build-gfortran_9.2.0_openmpi_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=xjet
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf -lhdf5_hl -lhdf5"
module load gnu/9.2.0 openmpi/3.1.4 netcdf/4.7.2
module load hdf5/1.10.5 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/mnt/lfs4/HFIP/hfv3gfs/Mark.Potts/gfortran_9.2.0_openmpi_g_jedwards_pio_update2
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 24 2>&1| tee build_$JOBID.log

