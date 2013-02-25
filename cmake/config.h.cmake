include(CheckFunctionExists)
include(CheckIncludeFile)
include(CheckLibraryExists)
include(CheckSymbolExists)
include(CheckTypeSize)

# BENCHFFT_LDOUBLE - set in CMakeLists.txt
# BENCHFFT_QUAD - set in CMakeLists.txt
# BENCHFFT_SINGLE - set in CMakeLists.txt
#set(CRAY_STACKSEG_END) - NOT USED
#set(C_ALLOCA) - NOT USED
set(DISABLE_FORTRAN true)
set(F77_DUMMY_MAIN)
set(F77_FUNC)
set(F77_FUNC_)
set(F77_FUNC_EQUIV)
#set(FC_DUMMY_MAIN_EQ_F77) - NOT USED
if(MSVC)
  set(FFTW_CC ${CMAKE_C_COMPILER})
elseif(CMAKE_COMPILER_IS_GNUCXX)
  if(NOT C_FLAGS_SET)
    include(CheckCCompilerFlag)
    set(check_c_flags
      -std=gnu99
      -fomit-frame-pointer
      -mtune=native
      -malign-double
      -fstrict-aliasing
      -fno-schedule-insns
      -ffast-math
      )
    set(idx 0)
    foreach(flg ${check_c_flags})
      CHECK_C_COMPILER_FLAG("${flg}" has_flag_${idx})
      if(has_flag_${idx})
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${flg}")
      endif()
      math(EXPR idx "${idx}+1")
    endforeach()
    set(C_FLAGS_SET true)
  endif()
  set(FFTW_CC "gcc ${CMAKE_C_FLAGS}")
endif()
set(FFTW_DEBUG)
set(FFTW_DEBUG_ALIGNMENT)
set(FFTW_DEBUG_MALLOC)
set(FFTW_ENABLE_ALLOCA) # TODO: how to detect? configure defines this
# FFTW_LDOUBLE - set in CMakeLists.txt
# FFTW_QUAD - set in CMakeLists.txt
set(FFTW_RANDOM_ESTIMATOR)
# FFTW_SINGLE - set in CMakeLists.txt
CHECK_FUNCTION_EXISTS(abort HAVE_ABORT)
CHECK_FUNCTION_EXISTS(alloca HAVE_ALLOCA) # TODO: configure finds and defines
CHECK_INCLUDE_FILE(alloca.h HAVE_ALLOCA_H)
set(HAVE_ALTIVEC)
set(HAVE_ALTIVEC_H)
set(HAVE_AVX) # TODO: detect?
CHECK_FUNCTION_EXISTS(BSDgettimeofday HAVE_BSDGETTIMEOFDAY)
CHECK_FUNCTION_EXISTS(clock_gettime HAVE_CLOCK_GETTIME)
CHECK_FUNCTION_EXISTS(cosl HAVE_COSL) # TODO: why not detected? fftw-3.3-libs defined 1
CHECK_INCLUDE_FILE(c_asm.h HAVE_C_ASM_H)
CHECK_SYMBOL_EXISTS(cosl math.h HAVE_DECL_COSL)
#CHECK_SYMBOL_EXISTS(cosq math.h HAVE_DECL_COSQ) - NOT USED
CHECK_SYMBOL_EXISTS(drand48 stdlib.h HAVE_DECL_DRAND48)
CHECK_SYMBOL_EXISTS(memalign stdlib.h;malloc.h HAVE_DECL_MEMALIGN)
CHECK_SYMBOL_EXISTS(posix_memalign stdlib.h HAVE_DECL_POSIX_MEMALIGN)
CHECK_SYMBOL_EXISTS(sinl math.h HAVE_DECL_SINL)
#CHECK_SYMBOL_EXISTS(sinq math.h HAVE_DECL_SINQ) - NOT USED
CHECK_SYMBOL_EXISTS(srand48 stdlib.h HAVE_DECL_SRAND48)
#CHECK_INCLUDE_FILE(dlfcn.h HAVE_DLFCN_H) - NOT USED
#set(HAVE_DOPRNT) - NOT USED
CHECK_FUNCTION_EXISTS(drand48 HAVE_DRAND48)
set(HAVE_FMA)
CHECK_FUNCTION_EXISTS(gethrtime HAVE_GETHRTIME)
CHECK_FUNCTION_EXISTS(gettimeofday HAVE_GETTIMEOFDAY)
set(HAVE_HRTIME_T)
CHECK_INCLUDE_FILE(intrinsics.h HAVE_INTRINSICS_H)
CHECK_INCLUDE_FILE(inttypes.h HAVE_INTTYPES_H)
CHECK_FUNCTION_EXISTS(isnan HAVE_ISNAN)
#CHECK_INCLUDE_FILE(libintl.h HAVE_LIBINTL_H) - NOT USED
#if(UNIX)
  #CHECK_LIBRARY_EXISTS(m log "" HAVE_LIBM) - NOT USED
#else()
  #set(HAVE_LIBM) - NOT USED
#endif()
set(HAVE_LIBQUADMATH)
#CHECK_INCLUDE_FILE(limits.h HAVE_LIMITS_H) - NOT USED
#CHECK_TYPE_SIZE("long double" LONG_DOUBLE) - NOT USED # HAVE_LONG_DOUBLE holds existence of type
CHECK_FUNCTION_EXISTS(mach_absolute_time HAVE_MACH_ABSOLUTE_TIME)
CHECK_INCLUDE_FILE(mach/mach_time.h HAVE_MACH_MACH_TIME_H)
CHECK_INCLUDE_FILE(malloc.h HAVE_MALLOC_H)
CHECK_FUNCTION_EXISTS(memalign HAVE_MEMALIGN)
#CHECK_INCLUDE_FILE(memory.h HAVE_MEMORY_H) - NOT USED
#CHECK_FUNCTION_EXISTS(memset HAVE_MEMSET) - NOT USED
set(HAVE_MIPS_ZBUS_TIMER)
#set(HAVE_MPI) - NOT USED
set(HAVE_NEON)
include(FindOpenMP)
set(HAVE_OPENMP OPENMP_FOUND)
if(OPENMP_FOUND AND NOT OPENMP_FLAGS_SET)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
  set(OPENMP_FLAGS_SET true)
endif()
CHECK_FUNCTION_EXISTS(posix_memalign HAVE_POSIX_MEMALIGN)
#set(HAVE_PTHREAD) - NOT USED
CHECK_FUNCTION_EXISTS(read_real_time HAVE_READ_REAL_TIME)
#CHECK_FUNCTION_EXISTS(sinl HAVE_SINL) - NOT USED
CHECK_FUNCTION_EXISTS(snprintf HAVE_SNPRINTF)
#CHECK_FUNCTION_EXISTS(sqrt HAVE_SQRT) - NOT USED
if(FFTW_LDOUBLE)
  set(HAVE_SSE2)
else()
  set(HAVE_SSE2 true)
  if(MSVC AND NOT SSE2_DEF_SET)
    add_definitions(/arch:SSE2)
    set(SSE2_DEF_SET true)
  endif()
endif()
CHECK_INCLUDE_FILE(stddef.h HAVE_STDDEF_H)
CHECK_INCLUDE_FILE(stdint.h HAVE_STDINT_H)
CHECK_INCLUDE_FILE(stdlib.h HAVE_STDLIB_H)
#CHECK_INCLUDE_FILE(strings.h HAVE_STRINGS_H) - NOT USED
CHECK_INCLUDE_FILE(string.h HAVE_STRING_H)
CHECK_FUNCTION_EXISTS(sysctl HAVE_SYSCTL)
#CHECK_INCLUDE_FILE(sys/stat.h HAVE_SYS_STAT_H) - NOT USED
CHECK_INCLUDE_FILE(sys/sysctl.h HAVE_SYS_SYSCTL_H)
CHECK_INCLUDE_FILE(sys/time.h HAVE_SYS_TIME_H)
CHECK_INCLUDE_FILE(sys/types.h HAVE_SYS_TYPES_H)
#CHECK_FUNCTION_EXISTS(tanl HAVE_TANL) - NOT USED
set(HAVE_THREADS)
CHECK_FUNCTION_EXISTS(time_base_to_time HAVE_TIME_BASE_TO_TIME)
CHECK_TYPE_SIZE(uintptr_t UINTPTR_T) # HAVE_UINTPTR_T holds existence of type
CHECK_INCLUDE_FILE(unistd.h HAVE_UNISTD_H)
#CHECK_FUNCTION_EXISTS(vprintf HAVE_VPRINTF) - NOT USED
#CHECK_FUNCTION_EXISTS(_mm_free HAVE__MM_FREE) - NOT USED
CHECK_FUNCTION_EXISTS(_mm_malloc HAVE__MM_MALLOC)
set(HAVE__RTC)
#set(LT_OBJDIR) - NOT USED
#set(NO_MINUS_C_MINUS_O) - NOT USED

set(PACKAGE fftw)
set(PACKAGE_VERSION ${VER_MAJ}.${VER_MIN}.${VER_PT})
#set(PACKAGE_BUGREPORT fftw@fftw.org) - NOT USED
#set(PACKAGE_URL http://www.fftw.org) - NOT USED
#set(PACKAGE_NAME ${PACKAGE}) - NOT USED
#set(PACKAGE_STRING ${PACKAGE}-${PACKAGE_VERSION}) - NOT USED
#set(PACKAGE_TARNAME ${PACKAGE}) - NOT USED

#set(PTHREAD_CREATE_JOINABLE) - NOT USED
CHECK_TYPE_SIZE(double SIZEOF_DOUBLE)
#CHECK_TYPE_SIZE(fftw_r2r_kind SIZEOF_FFTW_R2R_KIND) - NOT USED
CHECK_TYPE_SIZE(float SIZEOF_FLOAT)
#CHECK_TYPE_SIZE(int SIZEOF_INT) - NOT USED
#CHECK_TYPE_SIZE(long SIZEOF_LONG) - NOT USED
#CHECK_TYPE_SIZE("long long" SIZEOF_LONG_LONG) - NOT USED
#CHECK_TYPE_SIZE(MPI_Fint SIZEOF_MPI_FINT) - NOT USED
#CHECK_TYPE_SIZE(ptrdiff_t SIZEOF_PTRDIFF_T) - NOT USED
#CHECK_TYPE_SIZE(size_t SIZEOF_SIZE_T) - NOT USED
CHECK_TYPE_SIZE("unsigned int" SIZEOF_UNSIGNED_INT)
CHECK_TYPE_SIZE("unsigned long" SIZEOF_UNSIGNED_LONG)
CHECK_TYPE_SIZE("unsigned long long" SIZEOF_UNSIGNED_LONG_LONG)
CHECK_TYPE_SIZE("void*" SIZEOF_VOID_P)
#set(STACK_DIRECTION) - NOT USED
set(STDC_HEADERS 1)
if(HAVE_SYS_TIME_H)
  set(TIME_WITH_SYS_TIME 1)
else()
  set(TIME_WITH_SYS_TIME)
endif()
#set(USING_POSIX_THREADS) - NOT USED
set(VERSION ${PACKAGE_VERSION})
set(WINDOWS_F77_MANGLING)
set(WITH_G77_WRAPPERS)
if(MSVC)
  set(WITH_OUR_MALLOC 1)
else()
  set(WITH_OUR_MALLOC)
endif()
set(WITH_SLOW_TIMER)
# const
if(NOT DEFINED C_INLINE)
  # test how compiler defines inline (like autoconf's AC_C_INLINE)
  # http://www.cmake.org/pipermail/cmake/2007-September/016285.html
  message(STATUS "Determining inline definition")
  file(WRITE ${CMAKE_BINARY_DIR}/CMakeFiles/test_inline.c
    "/* Test source lifted from autoconf/c.m4 */\n"
    "typedef int foo_t;\n"
    "static inline foo_t static_foo() { return 0; }\n"
    "foo_t foo() { return 0; }\n"
    "int main(int argc, char* argv[]) { return 0; }\n"
    )
  set(C_INLINE_KEYWORD " ")
  foreach(KEYWORD inline __inline__ __inline)
    try_compile(C_HAS_${KEYWORD} ${CMAKE_BINARY_DIR}
      ${CMAKE_BINARY_DIR}/CMakeFiles/test_inline.c
      COMPILE_DEFINITIONS "-Dinline=${KEYWORD}"
      )
    if(C_HAS_${KEYWORD})
      set(C_INLINE TRUE CACHE INTERNAL "test_inline: boolean")
      set(C_INLINE_KEYWORD ${KEYWORD} CACHE INTERNAL "test_inline: keyword")
    endif()
  endforeach()
  if(C_INLINE)
    message(STATUS "Determining inline definition - done")
  else()
    message(STATUS "Determining inline definition - failed")
  endif()
endif(NOT DEFINED C_INLINE)
set(inline ${C_INLINE_KEYWORD})
# size_t
configure_file(${fftwroot}/cmake/config.h.in ${lib_dir}/config.h)
