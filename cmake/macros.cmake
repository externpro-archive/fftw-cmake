macro(generate_cscope_db)
  file(GLOB cscope_files ${CMAKE_BINARY_DIR}/cscope.*)
  list(LENGTH cscope_files len)
  if(NOT ${len} EQUAL 0)
    file(REMOVE ${cscope_files})
  endif()
  list(REMOVE_DUPLICATES master_src_list)
  file(WRITE ${CMAKE_BINARY_DIR}/cscope.files ${master_src_list})
  message(STATUS "Generating cscope database")
  execute_process(COMMAND cscope -b -q -k -i cscope.files
                  WORKING_DIRECTORY ${CMAKE_BINARY_DIR})
endmacro()

macro(master_src_list_append _DIR _SRCS)
  list(APPEND master_src_list ${_DIR}/CMakeLists.txt\n)
  file(GLOB msvc_files "${_DIR}/*.sln" "${_DIR}/*.vcxproj" "${_DIR}/*.vcxproj.filters")
  foreach(v ${msvc_files})
    list(APPEND master_src_list ${v}\n)
  endforeach()
  foreach(f ${_SRCS})
    # remove any relative parts with get_filename_component call
    # as this will help REMOVE_DUPLICATES
    if(IS_ABSOLUTE ${f})
      get_filename_component(f ${f} ABSOLUTE)
    else()
      get_filename_component(f ${_DIR}/${f} ABSOLUTE)
    endif()
    list(APPEND master_src_list ${f}\n)
  endforeach()
  if(NOT ${CMAKE_BINARY_DIR} MATCHES ${CMAKE_CURRENT_BINARY_DIR})
    set(master_src_list "${master_src_list}" PARENT_SCOPE)
  endif()
endmacro()

option(GENERATE_CSCOPE "always update cscope database" OFF)
set_property(GLOBAL PROPERTY USE_FOLDERS ON) # enables MSVC Solution Folders

