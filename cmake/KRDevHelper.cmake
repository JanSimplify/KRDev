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

# krdev_check_arguments(
#   PREFIX <prefix>
#   [NOT_NULL_KEYWORDS <keyword>...]
#   [ERROR_UNPARSED]
# )
function(krdev_check_arguments)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "krdev_check_arguments"
        "ERROR_UNPARSED"
        "PREFIX"
        "NOT_NULL_KEYWORDS"
    )

    if(krdev_check_arguments_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${arg_UNPARSED_ARGUMENTS}")
    endif()

    if(krdev_check_arguments_ERROR_UNPARSED AND ${krdev_check_arguments_PREFIX}_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unparsed arguments: ${${krdev_check_arguments_PREFIX}_UNPARSED_ARGUMENTS}")
    endif()

    foreach(keyword IN LISTS krdev_check_arguments_NOT_NULL_KEYWORDS)
        if(NOT ${krdev_check_arguments_PREFIX}_${keyword})
            message(FATAL_ERROR "Missing value: ${keyword}")
        endif()
    endforeach()
endfunction()

include(CMakePrintHelpers)

# krdev_foreach(
#   VARS <loop_var>...
#   [IN
#       [LISTS <list>...]
#       [ITEMS <item>...]
#       [ZIP_LISTS <list>...]
#   ]
#   [RANGE <start> <stop> [<step>]]
#   [CODE <code>]
# )
function(krdev_foreach)
    cmake_parse_arguments(
        PARSE_ARGV 0
        "arg"
        ""
        "CODE"
        "VARS;IN;RANGE"
    )

    krdev_check_arguments(
        PREFIX "arg"
        NOT_NULL_KEYWORDS "VARS"
        ERROR_UNPARSED
    )

    cmake_parse_arguments(
        "arg_in"
        ""
        ""
        "LISTS;ITEMS;ZIP_LISTS"
        ${arg_IN}
    )

    krdev_check_arguments(
        PREFIX "arg_in"
        ERROR_UNPARSED
    )

    if(arg_in_LISTS OR arg_in_ITEMS)
        foreach(${arg_VARS} IN LISTS ${arg_in_LISTS} ITEMS ${arg_in_ITEMS})
            cmake_language(EVAL CODE "${arg_CODE}")
        endforeach()
    endif()

    if(arg_in_ZIP_LISTS)
        foreach(${arg_VARS} IN ZIP_LISTS ${arg_in_ZIP_LISTS})
            cmake_language(EVAL CODE "${arg_CODE}")
        endforeach()
    endif()

    if(arg_RANGE)
        foreach(${arg_VARS} RANGE ${arg_RANGE})
            cmake_language(EVAL CODE "${arg_CODE}")
        endforeach()
    endif()
endfunction()

# krdev_json(
#   <out-var>
#   <op>
#   FROM <json>
#   KEY <path>...
# )
function(krdev_json)
    cmake_parse_arguments(
        PARSE_ARGV 2
        "arg"
        ""
        "FROM"
        "KEY"
    )

    krdev_check_arguments(
        PREFIX "arg"
        NOT_NULL_KEYWORDS "FROM" "KEY"
        ERROR_UNPARSED
    )

    string(JSON ${ARGV0} ${ARGV1} "${${arg_FROM}}" ${arg_KEY})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_get(
#   <out-var>
#   FROM <json>
#   KEY <path>...
# )
function(krdev_json_get)
    list(INSERT ARGV 1 "GET")
    krdev_json(${ARGV})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_type(
#   <out-var>
#   FROM <json>
#   KEY <path>...
# )
function(krdev_json_type)
    list(INSERT ARGV 1 "TYPE")
    krdev_json(${ARGV})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_member(
#   <out-var>
#   FROM <json>
#   KEY <path>...
# )
function(krdev_json_member)
    list(INSERT ARGV 1 "MEMBER")
    krdev_json(${ARGV})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_member(
#   <out-var>
#   FROM <json>
#   KEY <path>...
#   <index>
# )
function(krdev_json_length)
    list(INSERT ARGV 1 "LENGTH")
    krdev_json(${ARGV})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_set(
#   <json>
#   KEY <path>...
#   <value>
# )
function(krdev_json_set)
    list(INSERT ARGV 1 "SET" "FROM" "${ARGV0}")
    krdev_json(${ARGV})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_remove(
#   <json>
#   KEY <path>...
# )
function(krdev_json_remove)
    list(INSERT ARGV 1 "REMOVE" "FROM" "${ARGV0}")
    krdev_json(${ARGV})
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()

# krdev_json_equal(
#   <out-var>
#   FROM <json1> <json2>
# )
function(krdev_json_equal)
    cmake_parse_arguments(
        PARSE_ARGV 1
        "arg"
        ""
        ""
        "FROM"
    )

    krdev_check_arguments(
        PREFIX "arg"
        NOT_NULL_KEYWORDS "FROM"
        ERROR_UNPARSED
    )

    list(GET arg_FROM 0 json1)
    list(GET arg_FROM 1 json2)

    string(JSON ${ARGV0} EQUAL "${${json1}}" "${${json2}}")
    set(${ARGV0} "${${ARGV0}}" PARENT_SCOPE)
endfunction()
