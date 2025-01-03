find_package(Git QUIET)

# krdev_get_git_description(
#   OUTPUT_VARIABLE <outvar>
#   WORKING_DIRECTORY <dir>
#   [ALL]
#   [DIRTY]
#   [ALWAYS]
#   [LONG]
# )
function(krdev_get_git_description)
    cmake_parse_arguments(
        PARSE_ARGV 0
        ARG
        "ALL;DIRTY;ALWAYS;LONG"
        "OUTPUT_VARIABLE;WORKING_DIRECTORY"
        ""
    )

    if(NOT ARG_OUTPUT_VARIABLE)
        message(FATAL_ERROR "Missing required value: OUTPUT_VARIABLE")
    endif()

    if(NOT ARG_WORKING_DIRECTORY)
        message(FATAL_ERROR "Missing required value: WORKING_DIRECTORY")
    endif()

    if(NOT Git_FOUND)
        message(
            FATAL_ERROR
            "Could not find \"Git\" package configuration file."
        )
    endif()

    set(command_options)

    if(ARG_ALL)
        list(APPEND command_options --all)
    endif()

    if(ARG_DIRTY)
        list(APPEND command_options --dirty)
    endif()

    if(ARG_ALWAYS)
        list(APPEND command_options --always)
    endif()

    if(ARG_LONG)
        list(APPEND command_options --long)
    endif()

    execute_process(
        COMMAND ${GIT_EXECUTABLE} describe ${command_options}
        WORKING_DIRECTORY ${ARG_WORKING_DIRECTORY}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE git_describe
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(result)
        message(FATAL_ERROR "Failed to get git description: ${result}")
    endif()

    set(${ARG_OUTPUT_VARIABLE} "${git_describe}" PARENT_SCOPE)
endfunction(krdev_get_git_description)

# krdev_get_git_hash(
#   OUTPUT_VARIABLE <outvar>
#   WORKING_DIRECTORY <dir>
# )
function(krdev_get_git_hash)
    cmake_parse_arguments(
        PARSE_ARGV 0
        ARG
        ""
        "OUTPUT_VARIABLE;WORKING_DIRECTORY"
        ""
    )

    if(NOT ARG_OUTPUT_VARIABLE)
        message(FATAL_ERROR "Missing required value: OUTPUT_VARIABLE")
    endif()

    if(NOT ARG_WORKING_DIRECTORY)
        message(FATAL_ERROR "Missing required value: WORKING_DIRECTORY")
    endif()

    if(NOT Git_FOUND)
        message(
            FATAL_ERROR
            "Could not find \"Git\" package configuration file."
        )
    endif()

    execute_process(
        COMMAND ${GIT_EXECUTABLE} rev-parse HEAD
        WORKING_DIRECTORY ${ARG_WORKING_DIRECTORY}
        RESULT_VARIABLE result
        OUTPUT_VARIABLE git_hash
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(result)
        message(FATAL_ERROR "Failed to get git hash: ${result}")
    endif()

    set(${ARG_OUTPUT_VARIABLE} "${git_hash}" PARENT_SCOPE)
endfunction(krdev_get_git_hash)
