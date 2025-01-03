cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

#=============================
# Project
#=============================

project(KRDevTest)

if(PROJECT_IS_TOP_LEVEL)
    include(CTest)
    find_package(KRDev REQUIRED)
endif()

add_subdirectory(set_compile_option)

add_subdirectory(set_development_options)

add_subdirectory(get_git_info)
