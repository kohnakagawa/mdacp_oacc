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
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -acc -ta=nvidia,cc35,keep,cuda7.5,ptxinfo -Minfo=accel") # for sekirei
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -acc -ta=nvidia,cc60,keep,cuda8.0,ptxinfo -Minfo=accel") # for reedbush-l

# enable C++11
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

# set(CUDA_PATH /usr/local/cuda) # for normal installation directory
set(CUDA_PATH $ENV{CUDA_PATH})

link_directories(${CUDA_PATH}/lib64)
include_directories(${CUDA_PATH}/include)
include_directories(${CUDA_PATH}/samples/common/inc)

add_executable(mdacp ${mdacp_srcs})
target_link_libraries(mdacp cudart)
