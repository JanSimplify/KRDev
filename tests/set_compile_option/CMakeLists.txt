include(KRDevCompilerOption)

add_executable(
    krdev_test_set_compile_option
    c_option.c
    cxx_option.cpp
    test_main.cpp
)

krdev_targets_set_compile_options(
    TARGETS krdev_test_set_compile_option
    PRIVATE
        GCC_C_OPTIONS -DKRDEV_SET_C_OPTIONS_ON_GCC
        GCC_CXX_OPTIONS -DKRDEV_SET_CXX_OPTIONS_ON_GCC
        CLANG_C_OPTIONS -DKRDEV_SET_C_OPTIONS_ON_CLANG
        CLANG_CXX_OPTIONS -DKRDEV_SET_CXX_OPTIONS_ON_CLANG
        MSVC_OPTIONS "/DKRDEV_SET_OPTIONS_ON_MSVC"
)

add_test(
    NAME test_set_compile_option
    COMMAND krdev_test_set_compile_option
)

set(pass_string "no matched compiler ID")

if(CMAKE_C_COMPILER_ID MATCHES "GNU" OR CMAKE_CXX_COMPILER_ID MATCHES "GNU")
    string(CONCAT pass_string
        "^KRDEV_SET_C_OPTIONS_ON_GCC on c file\n"
        "KRDEV_SET_CXX_OPTIONS_ON_GCC on cxx file\n$"
    )
endif()

if(CMAKE_C_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    string(CONCAT pass_string
        "^KRDEV_SET_C_OPTIONS_ON_CLANG on c file\n"
        "KRDEV_SET_CXX_OPTIONS_ON_CLANG on cxx file\n$"
    )
endif()

if(MSVC)
    string(CONCAT pass_string
        "^KRDEV_SET_OPTIONS_ON_MSVC on c file\n"
        "KRDEV_SET_OPTIONS_ON_MSVC on cxx file\n$"
    )
endif()

set_tests_properties(
    test_set_compile_option
    PROPERTIES
        PASS_REGULAR_EXPRESSION
            "${pass_string}"
)
