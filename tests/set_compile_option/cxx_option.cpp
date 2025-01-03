// SPDX-License-Identifier: MIT
// SPDX-FileCopyrightText: Copyright (c) 2025 JanSimplify

#include <cstdio>

void print_test_cxx_compiler_option()
{
#ifdef KRDEV_SET_C_OPTIONS_ON_GCC
    printf("KRDEV_SET_C_OPTIONS_ON_GCC on cxx file\n");
#endif

#ifdef KRDEV_SET_CXX_OPTIONS_ON_GCC
    printf("KRDEV_SET_CXX_OPTIONS_ON_GCC on cxx file\n");
#endif

#ifdef KRDEV_SET_C_OPTIONS_ON_CLANG
    printf("KRDEV_SET_C_OPTIONS_ON_CLANG on cxx file\n");
#endif

#ifdef KRDEV_SET_CXX_OPTIONS_ON_CLANG
    printf("KRDEV_SET_CXX_OPTIONS_ON_CLANG on cxx file\n");
#endif

#ifdef KRDEV_SET_OPTIONS_ON_MSVC
    printf("KRDEV_SET_OPTIONS_ON_MSVC on cxx file\n");
#endif
}
