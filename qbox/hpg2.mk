#-------------------------------------------------------------------------------
#
#  hipergator2 UFRC, adapted from cori.mk
#
# module load fftw 
# module load xerces 
# module load intel/2018 openmpi

#  specific version number are the following
#  xerces/3.1.4   intel/2018    fftw/3.3.7  openmpi/3.1.2
#-------------------------------------------------------------------------------
#
 PLT=hpg2
#-------------------------------------------------------------------------------

 PLTOBJECTS = readTSC.o
 #HPC_LIBXML2_INC=/apps/lib/xml2/2.9.1/include/libxml2/libxml 
 HPC_LIBXML2_LIB=/apps/lib/xml2/2.9.1/lib

 CXX=icc
 LD=mpicc

 OPT= -O3  -qopenmp -restrict

 PLTFLAGS += $(OPT)  \
             -DUSE_MPI -DSCALAPACK -DADD_ \
             -DAPP_NO_THREADS -DXML_USE_NO_THREADS -DUSE_XERCES \
             -DMPICH_IGNORE_CXX_SEEK -DPARALLEL_FS -DUSE_FFTW3

# you could include libxml2 'include' directory
 INCLUDE = -I$(HPC_FFTW_INC) -I$(HPC_XERCES_INC) -I$(HPC_MKL_INC) \
	  #-I$(HPC_LIBXML2_INC) 

 CXXFLAGS= -D$(PLT) $(INCLUDE) $(PLTFLAGS) $(DFLAGS)

 LIBPATH = -L$(HPC_FFTW_LIB) \
	   -L$(HPC_XERCES_LIB) \
	   -L$(HPC_MKL_LIB)/lib/intel64 \
	   -L$(HPC_LIBXML2_LIB) \

 LIBS =  -lfftw3 -lxerces-c -lxml2 \
	 -lmkl_intel_lp64 -lmkl_core -lmkl_intel_thread \
	 -lmkl_scalapack_lp64 -lmkl_blacs_openmpi_lp64 

 LDFLAGS = $(LIBPATH) $(LIBS) -qopenmp 
