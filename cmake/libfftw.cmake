#######################################
# library sources
source_group("Header Files" FILES ${cfg_dir}/config.h)
list(APPEND ${lib_name}_libsrcs ${cfg_dir}/config.h)
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
file(GLOB api_hdrs ${fftwroot}/api/*.h)
source_group("Source Files\\api" FILES ${api_srcs})
source_group("Header Files\\api" FILES ${api_hdrs})
list(APPEND ${lib_name}_libsrcs ${api_srcs} ${api_hdrs})
########################
# dft
file(GLOB dft_srcs ${fftwroot}/dft/*.c)
file(GLOB dft_hdrs ${fftwroot}/dft/*.h)
source_group("Source Files\\dft" FILES ${dft_srcs})
source_group("Header Files\\dft" FILES ${dft_hdrs})
list(APPEND ${lib_name}_libsrcs ${dft_srcs} ${dft_hdrs})
#####
file(GLOB dft_scalar_srcs ${fftwroot}/dft/scalar/*.c)
file(GLOB dft_scalar_hdrs ${fftwroot}/dft/scalar/*.h)
source_group("Source Files\\dft\\scalar" FILES ${dft_scalar_srcs})
source_group("Header Files\\dft\\scalar" FILES ${dft_scalar_hdrs})
list(APPEND ${lib_name}_libsrcs ${dft_scalar_srcs} ${dft_scalar_hdrs})
#####
file(GLOB dft_scalar_codelets_srcs ${fftwroot}/dft/scalar/codelets/*.c)
source_group("Source Files\\dft\\scalar\\codelets" FILES ${dft_scalar_codelets_srcs})
list(APPEND ${lib_name}_libsrcs ${dft_scalar_codelets_srcs})
#####
file(GLOB dft_simd_hdrs ${fftwroot}/dft/simd/*.h)
source_group("Header Files\\dft\\simd" FILES ${dft_simd_hdrs})
list(APPEND ${lib_name}_libsrcs ${dft_simd_hdrs})
#####
file(GLOB dft_simd_sse2_srcs ${fftwroot}/dft/simd/sse2/*.c)
source_group("Source Files\\dft\\simd\\sse2" FILES ${dft_simd_sse2_srcs})
if(HAVE_SSE2)
  list(APPEND ${lib_name}_libsrcs ${dft_simd_sse2_srcs})
endif()
########################
# kernel
file(GLOB kernel_srcs ${fftwroot}/kernel/*.c)
file(GLOB kernel_hdrs ${fftwroot}/kernel/*.h)
source_group("Source Files\\kernel" FILES ${kernel_srcs})
source_group("Header Files\\kernel" FILES ${kernel_hdrs})
list(APPEND ${lib_name}_libsrcs ${kernel_srcs} ${kernel_hdrs})
########################
# rdft
file(GLOB rdft_srcs ${fftwroot}/rdft/*.c)
file(GLOB rdft_hdrs ${fftwroot}/rdft/*.h)
source_group("Source Files\\rdft" FILES ${rdft_srcs})
source_group("Header Files\\rdft" FILES ${rdft_hdrs})
list(APPEND ${lib_name}_libsrcs ${rdft_srcs} ${rdft_hdrs})
#####
file(GLOB rdft_scalar_srcs ${fftwroot}/rdft/scalar/*.c)
file(GLOB rdft_scalar_hdrs ${fftwroot}/rdft/scalar/*.h)
source_group("Source Files\\rdft\\scalar" FILES ${rdft_scalar_srcs})
source_group("Header Files\\rdft\\scalar" FILES ${rdft_scalar_hdrs})
list(APPEND ${lib_name}_libsrcs ${rdft_scalar_srcs} ${rdft_scalar_hdrs})
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
file(GLOB rdft_simd_hdrs ${fftwroot}/rdft/simd/*.h)
source_group("Header Files\\rdft\\simd" FILES ${rdft_simd_hdrs})
list(APPEND ${lib_name}_libsrcs ${rdft_simd_hdrs})
#####
file(GLOB rdft_simd_sse2_srcs ${fftwroot}/rdft/simd/sse2/*.c)
source_group("Source Files\\rdft\\simd\\sse2" FILES ${rdft_simd_sse2_srcs})
if(HAVE_SSE2)
  list(APPEND ${lib_name}_libsrcs ${rdft_simd_sse2_srcs})
endif()
########################
# reodft
file(GLOB reodft_srcs ${fftwroot}/reodft/*.c)
file(GLOB reodft_hdrs ${fftwroot}/reodft/*.h)
source_group("Source Files\\reodft" FILES ${reodft_srcs})
source_group("Header Files\\reodft" FILES ${reodft_hdrs})
list(APPEND ${lib_name}_libsrcs ${reodft_srcs} ${reodft_hdrs})
########################
# simd-support
file(GLOB simdsupport_srcs ${fftwroot}/simd-support/*.c)
file(GLOB simdsupport_hdrs ${fftwroot}/simd-support/*.h)
source_group("Source Files\\simd-support" FILES ${simdsupport_srcs})
source_group("Header Files\\simd-support" FILES ${simdsupport_hdrs})
list(APPEND ${lib_name}_libsrcs ${simdsupport_srcs} ${simdsupport_hdrs})
########################
# threads
file(GLOB threads_srcs ${fftwroot}/threads/*.c)
list(REMOVE_ITEM threads_srcs ${fftwroot}/threads/threads.c)
file(GLOB threads_hdrs ${fftwroot}/threads/*.h)
source_group("Source Files\\threads" FILES ${threads_srcs})
source_group("Header Files\\threads" FILES ${threads_hdrs})
list(APPEND ${lib_name}_libsrcs ${threads_srcs} ${threads_hdrs})
#######################################
# library
add_library(${lib_name} STATIC ${${lib_name}_libsrcs})
target_include_directories(${lib_name} PUBLIC $<BUILD_INTERFACE:${cfg_dir}>
  $<BUILD_INTERFACE:${fftwroot}/api>
  $<BUILD_INTERFACE:${fftwroot}/dft>
  $<BUILD_INTERFACE:${fftwroot}/kernel>
  $<BUILD_INTERFACE:${fftwroot}/rdft>
  PRIVATE
  ${fftwroot}/dft/scalar
  ${fftwroot}/dft/simd
  ${fftwroot}/rdft/scalar
  ${fftwroot}/rdft/simd
  ${fftwroot}/reodft
  ${fftwroot}/simd-support
  ${fftwroot}/threads
  )
set_property(TARGET ${lib_name} PROPERTY COMPILE_DEFINITIONS
  LIBFFTWF33_EXPORTS
  )
set_target_properties(${lib_name} PROPERTIES
  OUTPUT_NAME ${lib_name}${ver}
  PREFIX "" # strip off the "lib" prefix, since it's already libfftw
  )
set_property(TARGET ${lib_name} PROPERTY FOLDER "libfftw")
install(TARGETS ${lib_name} EXPORT ${targetsFile}
  RUNTIME DESTINATION bin
  LIBRARY DESTINATION lib
  ARCHIVE DESTINATION lib
  )
master_src_list_append(${CMAKE_CURRENT_SOURCE_DIR} "${${lib_name}_libsrcs}")
