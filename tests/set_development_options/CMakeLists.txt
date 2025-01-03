include(KRDevCompilerOption)

add_executable(krdev_test_develop_options)

target_sources(
    krdev_test_develop_options
    PRIVATE
        FILE_SET krdev_test_develop_options_header_set
        TYPE HEADERS
        FILES c_file.h cxx_file.hpp
    PRIVATE
        test_main.cpp
        c_file.c
        cxx_file.cpp
)

krdev_targets_set_development_options(
    TARGETS
        krdev_test_develop_options
    WARNING_AS_ERROR
    ERROR_AS_FATAL
)
