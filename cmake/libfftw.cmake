#######################################
# library sources
source_group("Header Files" FILES ${lib_dir}/config.h)
list(APPEND ${lib_name}_libsrcs ${lib_dir}/config.h)
set(cmake_srcs
  ${fftwroot}/cmake/libfftw.cmake
  ${fftwroot}/cmake/config.h.cmake
  ${fftwroot}/cmake/config.h.in
  )
source_group(cmake FILES ${cmake_srcs})
list(APPEND ${lib_name}_libsrcs ${cmake_srcs})
########################
# api
file(GLOB api_srcs ${fftwroot}/api/*.c)
source_group("Source Files\\api" FILES ${api_srcs})
list(APPEND ${lib_name}_libsrcs ${api_srcs})
########################
# dft
file(GLOB dft_srcs ${fftwroot}/dft/*.c)
source_group("Source Files\\dft" FILES ${dft_srcs})
list(APPEND ${lib_name}_libsrcs ${dft_srcs})
#####
file(GLOB dft_scalar_srcs ${fftwroot}/dft/scalar/*.c)
source_group("Source Files\\dft\\scalar" FILES ${dft_scalar_srcs})
list(APPEND ${lib_name}_libsrcs ${dft_scalar_srcs})
#####
file(GLOB dft_scalar_codelets_srcs ${fftwroot}/dft/scalar/codelets/*.c)
source_group("Source Files\\dft\\scalar\\codelets" FILES ${dft_scalar_codelets_srcs})
list(APPEND ${lib_name}_libsrcs ${dft_scalar_codelets_srcs})
#####
file(GLOB dft_simd_sse2_srcs ${fftwroot}/dft/simd/sse2/*.c)
source_group("Source Files\\dft\\simd\\sse2" FILES ${dft_simd_sse2_srcs})
if(HAVE_SSE2)
  list(APPEND ${lib_name}_libsrcs ${dft_simd_sse2_srcs})
endif()
########################
# kernel
file(GLOB kernel_srcs ${fftwroot}/kernel/*.c)
source_group("Source Files\\kernel" FILES ${kernel_srcs})
list(APPEND ${lib_name}_libsrcs ${kernel_srcs})
########################
# rdft
file(GLOB rdft_srcs ${fftwroot}/rdft/*.c)
source_group("Source Files\\rdft" FILES ${rdft_srcs})
list(APPEND ${lib_name}_libsrcs ${rdft_srcs})
#####
file(GLOB rdft_scalar_srcs ${fftwroot}/rdft/scalar/*.c)
source_group("Source Files\\rdft\\scalar" FILES ${rdft_scalar_srcs})
list(APPEND ${lib_name}_libsrcs ${rdft_scalar_srcs})
#####
file(GLOB rdft_scalar_r2cb_srcs ${fftwroot}/rdft/scalar/r2cb/*.c)
source_group("Source Files\\rdft\\scalar\\r2cb" FILES ${rdft_scalar_r2cb_srcs})
list(APPEND ${lib_name}_libsrcs ${rdft_scalar_r2cb_srcs})
#####
file(GLOB rdft_scalar_r2cf_srcs ${fftwroot}/rdft/scalar/r2cf/*.c)
source_group("Source Files\\rdft\\scalar\\r2cf" FILES ${rdft_scalar_r2cf_srcs})
list(APPEND ${lib_name}_libsrcs ${rdft_scalar_r2cf_srcs})
#####
file(GLOB rdft_scalar_r2r_srcs ${fftwroot}/rdft/scalar/r2r/*.c)
source_group("Source Files\\rdft\\scalar\\r2r" FILES ${rdft_scalar_r2r_srcs})
list(APPEND ${lib_name}_libsrcs ${rdft_scalar_r2r_srcs})
#####
file(GLOB rdft_simd_sse2_srcs ${fftwroot}/rdft/simd/sse2/*.c)
source_group("Source Files\\rdft\\simd\\sse2" FILES ${rdft_simd_sse2_srcs})
if(HAVE_SSE2)
  list(APPEND ${lib_name}_libsrcs ${rdft_simd_sse2_srcs})
endif()
########################
# reodft
file(GLOB reodft_srcs ${fftwroot}/reodft/*.c)
source_group("Source Files\\reodft" FILES ${reodft_srcs})
list(APPEND ${lib_name}_libsrcs ${reodft_srcs})
########################
# simd-support
file(GLOB simdsupport_srcs ${fftwroot}/simd-support/*.c)
source_group("Source Files\\simd-support" FILES ${simdsupport_srcs})
list(APPEND ${lib_name}_libsrcs ${simdsupport_srcs})
########################
# threads
file(GLOB threads_srcs ${fftwroot}/threads/*.c)
list(REMOVE_ITEM threads_srcs ${fftwroot}/threads/threads.c)
source_group("Source Files\\threads" FILES ${threads_srcs})
list(APPEND ${lib_name}_libsrcs ${threads_srcs})
#######################################
# library
add_library(${lib_name} STATIC ${${lib_name}_libsrcs})
set_property(TARGET ${lib_name} PROPERTY INCLUDE_DIRECTORIES
  ${lib_dir}
  ${fftwroot}/api
  ${fftwroot}/dft
  ${fftwroot}/dft/scalar
  ${fftwroot}/dft/simd
  ${fftwroot}/kernel
  ${fftwroot}/rdft
  ${fftwroot}/rdft/scalar
  ${fftwroot}/rdft/simd
  ${fftwroot}/reodft
  ${fftwroot}/simd-support
  ${fftwroot}/threads
  )
set_property(TARGET ${lib_name} PROPERTY COMPILE_DEFINITIONS
  LIBFFTWF33_EXPORTS
  )
set_property(TARGET ${lib_name} PROPERTY FOLDER "libfftw")
install(TARGETS ${lib_name} DESTINATION lib${NUMBITS})
