cmake_minimum_required(VERSION 2.8)
set(CMAKE_VERBOSE_MAKEFILE 1)

set(CMAKE_BUILD_TYPE Release)

file(GLOB mdacp_cpp_srcs ./src/*.cc)
set(mdacp_srcs ${mdacp_cpp_srcs})
include_directories(./include)

# add warning flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Minform=warn")

# add OpenMP flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mp")

add_definitions(-DGPU_OACC)
set(OACC_FLAGS "-acc -Minfo=accel -ta=nvidia,keep,ptxinfo")
if (DEFINED GPU_ARCH)
  if (GPU_ARCH STREQUAL KEPLER)
    set(OACC_FLAGS "${OACC_FLAGS},cc35,cuda7.5")
  elseif (GPU_ARCH STREQUAL PASCAL)
    set(OACC_FLAGS "${OACC_FLAGS},cc60,cuda8.0")
  else()
    message(FATAL_ERROR "Non-supported GPU architecture!")
  endif ()
endif ()
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OACC_FLAGS}")

# enable C++11
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

add_executable(mdacp ${mdacp_srcs})
