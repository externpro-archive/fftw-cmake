# FFTW_FOUND - fftw was found
# FFTW_INCLUDE_DIR - the fftw include directory
# FFTW_LIBRARIES - the fftw libraries
set(prj fftw)
# this file (-config) installed to share/cmake (see top-level CMakeLists.txt)
get_filename_component(SELF_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)
get_filename_component(XP_ROOTDIR "${SELF_DIR}/../.." ABSOLUTE)
string(TOUPPER ${prj} PRJ)
if(UNIX)
  set(${PRJ}_LIBRARIES
    optimized fftw3  debug fftw3-d  # double precision FFTW
    optimized fftw3f debug fftw3f-d # single precision FFTW
    )
else()
  # targets file (-targets) installed to lib${NUMBITS}/cmake
  include(${XP_ROOTDIR}/lib${NUMBITS}/cmake/${prj}-targets.cmake)
  set(${PRJ}_LIBRARIES fftw3)
endif()
find_path(${PRJ}_INCLUDE_DIR fftw3/fftw3.h PATHS ${XP_ROOTDIR}/include NO_DEFAULT_PATH)
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(${prj}
  REQUIRED_VARS
    ${PRJ}_INCLUDE_DIR
    ${PRJ}_LIBRARIES
  )
mark_as_advanced(${PRJ}_INCLUDE_DIR ${PRJ}_LIBRARIES)
