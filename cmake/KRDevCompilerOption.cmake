# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright (c) 2025 JanSimplify
#[[
MIT License

Copyright (c) 2025 JanSimplify

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

include_guard(GLOBAL)

include(CheckCCompilerFlag)
include(CheckCXXCompilerFlag)

# krdev_targets_set_compile_options(
#   TARGETS [targets...]
#   [<PRIVATE|PUBLIC|INTERFACE>
#       [MSVC_OPTIONS options1...]
#       [GCC_C_OPTIONS options2...]
#       [GCC_CXX_OPTIONS options3...]
#       [CLANG_C_OPTIONS options4...]
#       [CLANG_CXX_OPTIONS options5...]
#   ]...
# )
function(krdev_targets_set_compile_options)
    set(options)
    set(one_value_keywords)
    set(multi_value_keywords "TARGETS;PUBLIC;INTERFACE;PRIVATE")

    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
    )

    if(arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    set(sub_options "MSVC_OPTIONS;GCC_C_OPTIONS;GCC_CXX_OPTIONS;CLANG_C_OPTIONS;CLANG_CXX_OPTIONS")

    cmake_parse_arguments(
        arg_PUBLIC
        ""
        ""
        "${sub_options}"
        ${arg_PUBLIC}
    )

    if(arg_PUBLIC_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_PUBLIC_UNPARSED_ARGUMENTS}")
    endif()

    cmake_parse_arguments(
        arg_INTERFACE
        ""
        ""
        "${sub_options}"
        ${arg_INTERFACE}
    )

    if(arg_INTERFACE_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_INTERFACE_UNPARSED_ARGUMENTS}")
    endif()

    cmake_parse_arguments(
        arg_PRIVATE
        ""
        ""
        "${sub_options}"
        ${arg_PRIVATE}
    )

    if(arg_PRIVATE_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_PRIVATE_UNPARSED_ARGUMENTS}")
    endif()

    foreach(target IN LISTS arg_TARGETS)
        target_compile_options(
            ${target}
            PUBLIC
                "$<$<COMPILE_LANG_AND_ID:C,GNU>:${arg_PUBLIC_GCC_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:${arg_PUBLIC_GCC_CXX_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:C,Clang>:${arg_PUBLIC_CLANG_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,Clang>:${arg_PUBLIC_CLANG_CXX_OPTIONS}>"
                "$<$<OR:$<COMPILE_LANG_AND_ID:C,MSVC>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:${arg_PUBLIC_MSVC_OPTIONS}>"
            INTERFACE
                "$<$<COMPILE_LANG_AND_ID:C,GNU>:${arg_INTERFACE_GCC_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:${arg_INTERFACE_GCC_CXX_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:C,Clang>:${arg_INTERFACE_CLANG_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,Clang>:${arg_INTERFACE_CLANG_CXX_OPTIONS}>"
                "$<$<OR:$<COMPILE_LANG_AND_ID:C,MSVC>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:${arg_INTERFACE_MSVC_OPTIONS}>"
            PRIVATE
                "$<$<COMPILE_LANG_AND_ID:C,GNU>:${arg_PRIVATE_GCC_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:${arg_PRIVATE_GCC_CXX_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:C,Clang>:${arg_PRIVATE_CLANG_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,Clang>:${arg_PRIVATE_CLANG_CXX_OPTIONS}>"
                "$<$<OR:$<COMPILE_LANG_AND_ID:C,MSVC>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:${arg_PRIVATE_MSVC_OPTIONS}>"
        )
    endforeach()
endfunction(krdev_targets_set_compile_options)

# krdev_targets_set_link_options(
#   TARGETS [targets...]
#   [<PRIVATE|PUBLIC|INTERFACE>
#       [MSVC_OPTIONS options1...]
#       [GCC_C_OPTIONS options2...]
#       [GCC_CXX_OPTIONS options3...]
#       [CLANG_C_OPTIONS options4...]
#       [CLANG_CXX_OPTIONS options5...]
#   ]...
# )
function(krdev_targets_set_link_options)
    set(options)
    set(one_value_keywords)
    set(multi_value_keywords "TARGETS;PUBLIC;INTERFACE;PRIVATE")

    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
    )

    if(arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    set(sub_options "MSVC_OPTIONS;GCC_C_OPTIONS;GCC_CXX_OPTIONS;CLANG_C_OPTIONS;CLANG_CXX_OPTIONS")

    cmake_parse_arguments(
        arg_PUBLIC
        ""
        ""
        "${sub_options}"
        ${arg_PUBLIC}
    )

    if(arg_PUBLIC_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_PUBLIC_UNPARSED_ARGUMENTS}")
    endif()

    cmake_parse_arguments(
        arg_INTERFACE
        ""
        ""
        "${sub_options}"
        ${arg_INTERFACE}
    )

    if(arg_INTERFACE_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_INTERFACE_UNPARSED_ARGUMENTS}")
    endif()

    cmake_parse_arguments(
        arg_PRIVATE
        ""
        ""
        "${sub_options}"
        ${arg_PRIVATE}
    )

    if(arg_PRIVATE_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_PRIVATE_UNPARSED_ARGUMENTS}")
    endif()

    foreach(target IN LISTS arg_TARGETS)
        target_link_options(
            ${target}
            PUBLIC
                "$<$<COMPILE_LANG_AND_ID:C,GNU>:${arg_PUBLIC_GCC_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:${arg_PUBLIC_GCC_CXX_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:C,Clang>:${arg_PUBLIC_CLANG_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,Clang>:${arg_PUBLIC_CLANG_CXX_OPTIONS}>"
                "$<$<OR:$<COMPILE_LANG_AND_ID:C,MSVC>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:${arg_PUBLIC_MSVC_OPTIONS}>"
            INTERFACE
                "$<$<COMPILE_LANG_AND_ID:C,GNU>:${arg_INTERFACE_GCC_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:${arg_INTERFACE_GCC_CXX_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:C,Clang>:${arg_INTERFACE_CLANG_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,Clang>:${arg_INTERFACE_CLANG_CXX_OPTIONS}>"
                "$<$<OR:$<COMPILE_LANG_AND_ID:C,MSVC>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:${arg_INTERFACE_MSVC_OPTIONS}>"
            PRIVATE
                "$<$<COMPILE_LANG_AND_ID:C,GNU>:${arg_PRIVATE_GCC_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,GNU>:${arg_PRIVATE_GCC_CXX_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:C,Clang>:${arg_PRIVATE_CLANG_C_OPTIONS}>"
                "$<$<COMPILE_LANG_AND_ID:CXX,Clang>:${arg_PRIVATE_CLANG_CXX_OPTIONS}>"
                "$<$<OR:$<COMPILE_LANG_AND_ID:C,MSVC>,$<COMPILE_LANG_AND_ID:CXX,MSVC>>:${arg_PRIVATE_MSVC_OPTIONS}>"
        )
    endforeach()
endfunction(krdev_targets_set_link_options)

# krdev_targets_set_development_options(
#   TARGETS [targets...]
#   [WARNING_AS_ERROR]
#   [ERROR_AS_FATAL]
# )
function(krdev_targets_set_development_options)
    set(options "WARNING_AS_ERROR;ERROR_AS_FATAL")
    set(one_value_keywords)
    set(multi_value_keywords "TARGETS")

    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
    )

    if(arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    # https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html
    # https://gcc.gnu.org/onlinedocs/gcc/C_002b_002b-Dialect-Options.html#C_002b_002b-Dialect-Options
    set(gcc_develop_options
        # base
        -Wall
        -Wextra
        # iso
        -pedantic
        -Wdeprecated
        # declaration
        -Wshadow
        -Wundef
        -Wunused-const-variable
        -Wmissing-declarations
        # conversion
        -Wconversion
        -Wsign-conversion
        -Warith-conversion
        -Wcast-qual
        -Wcast-align=strict
        # float
        -Wdouble-promotion
        -Wfloat-equal
        # format
        -Wformat=2
        -Wformat-overflow=2
        -Wformat-truncation=2
        -Wformat-signedness
        # switch case
        -Wimplicit-fallthrough=5
        # flow control statement
        -Wduplicated-cond
        -Wduplicated-branches
        -Wlogical-op
        # others
        -Wmissing-include-dirs
        -Wreturn-type
        -Wnull-dereference
    )

    set(gcc_c_develop_options
        ${gcc_develop_options}
        -Wnested-externs
        -Wbad-function-cast
        -Wmissing-prototypes
        -Wstrict-prototypes
    )

    if(CMAKE_C_COMPILER_ID MATCHES "GNU")
        check_c_compiler_flag("-Wmissing-variable-declarations" KRDEV_GCC_C_SUPPORT_MISSING_VARIABLE_DECLARATIONS)
        if(KRDEV_GCC_C_SUPPORT_MISSING_VARIABLE_DECLARATIONS)
            list(APPEND gcc_c_develop_options "-Wmissing-variable-declarations")
        endif()
    endif()

    set(gcc_cxx_develop_options
        ${gcc_develop_options}
        -Wuseless-cast
        -Wold-style-cast
        -Wstrict-null-sentinel
        -Wnon-virtual-dtor
        -Wextra-semi
        -Wcatch-value=3
        -Wplacement-new=2
        -Waligned-new=all
        -Wredundant-tags
        -Wmismatched-tags
        -Wsuggest-final-types
        -Wsuggest-final-methods
        -Wsuggest-override
    )

    if(CMAKE_CXX_COMPILER_ID MATCHES "GNU")
        check_cxx_compiler_flag("-Wnrvo" KRDEV_GCC_CXX_SUPPORT_NRVO)
        if(KRDEV_GCC_CXX_SUPPORT_NRVO)
            list(APPEND gcc_cxx_develop_options "-Wnrvo")
        endif()
    endif()

    # https://clang.llvm.org/docs/DiagnosticsReference.html
    set(clang_develop_options
        # base
        -Wall
        -Wextra
        # iso
        -pedantic
        -Wdeprecated
        # declaration
        -Wshadow-all
        -Wunused-const-variable
        -Wunused-exception-parameter
        -Wundef
        -Wundefined-internal-type
        -Wmissing-prototypes
        # conversion
        -Wconversion
        -Wcast-qual
        -Wcast-align
        # float
        -Wdouble-promotion
        -Wfloat-equal
        # format
        -Wformat=2
        -Wformat-non-iso
        # -Wformat-signedness
        -Wformat-pedantic
        -Wformat-type-confusion
        # switch case
        -Wimplicit-fallthrough
        # flow control statement
        -Wlogical-op-parentheses
        # others
        -Wmissing-include-dirs
        -Wnewline-eof
        -Wundefined-reinterpret-cast
    )

    set(clang_c_develop_options
        ${clang_develop_options}
        -Wmissing-prototypes
        -Wmissing-variable-declarations
    )

    set(clang_cxx_develop_options
        ${clang_develop_options}
        -Wold-style-cast
        -Woverloaded-virtual
        -Wnon-virtual-dtor
        -Wextra-semi
        -Wextra-semi-stmt
        -Wsuggest-override
    )

    # https://learn.microsoft.com/en-us/cpp/build/reference/compiler-option-warning-level
    # https://learn.microsoft.com/en-us/cpp/preprocessor/compiler-warnings-that-are-off-by-default
    # https://github.com/dotnet/project-system/issues/5352
    set(msvc_develop_options
        # base
        /W4
        # iso
        /permissive-
        /we4289
        # declaration
        /w44668
        # conversion
        /w44242 # narrow cast
        /w44254 # narrowly cast field bits
        /w44365 # conversion from signed to unsigned
        /w44287 # unsigned/negative constant mismatch
        /w44800 # other type to bool
        /w44388
        /w44296 # test unsigned less 0, or greater equal 0
        /w44165 # test HRESULT
        /w44905 # LPSTR
        /w44906 # LPWSTR
        /w44191 # bad function ptr cast
        # /w44311 # pointer truncation
        /w44946
        # switch case
        /w44062 # missing case label and no default
        # other
        /w44255 # strict prototypes, C only
        /w44464 # include <../xx.h>
        /w44746 # a volatile variable is accessed directly
        /w44555
        /w44768
        /w44545
        /w44546
        /w44547
        /w44549
        /w44608
        # C++
        /w44263 # function hide virtual functions from base class
        /w44265 # has virtual member function with non-virtual dtor
        /w44355 # using this in initializer list
        /w44471 # enum forward declaration without underlying type
    )

    krdev_targets_set_compile_options(
        TARGETS ${arg_TARGETS}
        PRIVATE
            GCC_C_OPTIONS ${gcc_c_develop_options}
            GCC_CXX_OPTIONS ${gcc_cxx_develop_options}
            CLANG_C_OPTIONS ${clang_c_develop_options}
            CLANG_CXX_OPTIONS ${clang_cxx_develop_options}
            MSVC_OPTIONS ${msvc_develop_options}
    )

    if(arg_WARNING_AS_ERROR)
        krdev_targets_set_compile_options(
            TARGETS ${arg_TARGETS}
            PRIVATE
                GCC_C_OPTIONS -Werror
                GCC_CXX_OPTIONS -Werror
                CLANG_C_OPTIONS -Werror
                CLANG_CXX_OPTIONS -Werror
                MSVC_OPTIONS /WX
        )
    endif()

    if(arg_ERROR_AS_FATAL)
        krdev_targets_set_compile_options(
            TARGETS ${arg_TARGETS}
            PRIVATE
                GCC_C_OPTIONS -Wfatal-errors
                GCC_CXX_OPTIONS -Wfatal-errors
                CLANG_C_OPTIONS -Wfatal-errors
                CLANG_CXX_OPTIONS -Wfatal-errors
        )
    endif()
endfunction(krdev_targets_set_development_options)

# krdev_targets_set_sanitizer(
#   TARGETS [targets...]
#   [ADDRESS]
#   [UNDEFINED]
# )
function(krdev_targets_set_sanitizer)
    set(options "ADDRESS;UNDEFINED")
    set(one_value_keywords)
    set(multi_value_keywords "TARGETS")

    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
    )

    if(arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    if(arg_ADDRESS)
        krdev_targets_set_compile_options(
            TARGETS ${arg_TARGETS}
            PRIVATE
                GCC_C_OPTIONS "-fsanitize=address"
                GCC_CXX_OPTIONS "-fsanitize=address"
                CLANG_C_OPTIONS "-fsanitize=address"
                CLANG_CXX_OPTIONS "-fsanitize=address"
                MSVC_OPTIONS "/fsanitize=address"
        )
        krdev_targets_set_link_options(
            TARGETS ${arg_TARGETS}
            PRIVATE
                GCC_C_OPTIONS "-fsanitize=address"
                GCC_CXX_OPTIONS "-fsanitize=address"
                CLANG_C_OPTIONS "-fsanitize=address"
                CLANG_CXX_OPTIONS "-fsanitize=address"
        )
    endif()

    if(arg_UNDEFINED)
        krdev_targets_set_compile_options(
            TARGETS ${arg_TARGETS}
            PRIVATE
                GCC_C_OPTIONS "-fsanitize=undefined"
                GCC_CXX_OPTIONS "-fsanitize=undefined"
                CLANG_C_OPTIONS "-fsanitize=undefined"
                CLANG_CXX_OPTIONS "-fsanitize=undefined"
                MSVC_OPTIONS "/fsanitize=undefined"
        )
        krdev_targets_set_link_options(
            TARGETS ${arg_TARGETS}
            PRIVATE
                GCC_C_OPTIONS "-fsanitize=undefined"
                GCC_CXX_OPTIONS "-fsanitize=undefined"
                CLANG_C_OPTIONS "-fsanitize=undefined"
                CLANG_CXX_OPTIONS "-fsanitize=undefined"
        )
    endif()
endfunction(krdev_targets_set_sanitizer)

# krdev_targets_set_coverage(
#   TARGETS [targets...]
# )
function(krdev_targets_set_coverage)
    set(options)
    set(one_value_keywords)
    set(multi_value_keywords "TARGETS")

    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        "${options}"
        "${one_value_keywords}"
        "${multi_value_keywords}"
    )

    if(arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    if(NOT arg_TARGETS)
        message(FATAL_ERROR "${CMAKE_CURRENT_FUNCTION} called with incorrect number of arguments")
    endif()

    krdev_targets_set_compile_options(
        TARGETS ${arg_TARGETS}
        PRIVATE
            GCC_C_OPTIONS "--coverage"
            GCC_CXX_OPTIONS "--coverage"
            CLANG_C_OPTIONS "--coverage"
            CLANG_CXX_OPTIONS "--coverage"
    )

    krdev_targets_set_link_options(
        TARGETS ${arg_TARGETS}
        PUBLIC
            GCC_C_OPTIONS "--coverage"
            GCC_CXX_OPTIONS "--coverage"
            CLANG_C_OPTIONS "--coverage"
            CLANG_CXX_OPTIONS "--coverage"
    )
endfunction(krdev_targets_set_coverage)
