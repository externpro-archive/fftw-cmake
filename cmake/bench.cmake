#######################################
# executable dependencies and libraries
list(APPEND ${exe_name}_deps ${lib_name})
if(UNIX)
  list(APPEND ${exe_name}_deps m) # math library
endif()
#######################################
# executable sources
set(cmake_srcs
  ${fftwroot}/cmake/bench.cmake
  )
source_group(cmake FILES ${cmake_srcs})
list(APPEND ${exe_name}_srcs ${cmake_srcs})
########################
# bench
file(GLOB bench_srcs ${fftwroot}/tests/*.c)
source_group("Source Files\\bench" FILES ${bench_srcs})
list(APPEND ${exe_name}_srcs ${bench_srcs})
########################
# libbench2
file(GLOB libbench2_srcs ${fftwroot}/libbench2/*.c)
list(REMOVE_ITEM libbench2_srcs ${fftwroot}/libbench2/useropt.c)
source_group("Source Files\\libbench2" FILES ${libbench2_srcs})
list(APPEND ${exe_name}_srcs ${libbench2_srcs})
#######################################
# executable
add_executable(${exe_name} ${${exe_name}_srcs})
add_dependencies(${exe_name} ${${exe_name}_deps})
target_link_libraries(${exe_name} ${${exe_name}_deps})
set_property(TARGET ${exe_name} PROPERTY INCLUDE_DIRECTORIES
  ${lib_dir}
  ${fftwroot}/api
  ${fftwroot}/dft
  ${fftwroot}/kernel
  ${fftwroot}/rdft
  ${fftwroot}/libbench2
  )
set_property(TARGET ${exe_name} PROPERTY FOLDER "bench")
master_src_list_append(${CMAKE_CURRENT_SOURCE_DIR} "${${exe_name}_srcs}")
