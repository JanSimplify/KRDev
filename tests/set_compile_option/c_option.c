/* SPDX-License-Identifier: MIT */
/* SPDX-FileCopyrightText: Copyright (c) 2025 JanSimplify */

#include <stdio.h>

void print_test_c_compiler_option()
{
#ifdef KRDEV_SET_C_OPTIONS_ON_GCC
    printf("KRDEV_SET_C_OPTIONS_ON_GCC on c file\n");
#endif

#ifdef KRDEV_SET_CXX_OPTIONS_ON_GCC
    printf("KRDEV_SET_CXX_OPTIONS_ON_GCC on c file\n");
#endif

#ifdef KRDEV_SET_C_OPTIONS_ON_CLANG
    printf("KRDEV_SET_C_OPTIONS_ON_CLANG on c file\n");
#endif

#ifdef KRDEV_SET_CXX_OPTIONS_ON_CLANG
    printf("KRDEV_SET_CXX_OPTIONS_ON_CLANG on c file\n");
#endif

#ifdef KRDEV_SET_OPTIONS_ON_MSVC
    printf("KRDEV_SET_OPTIONS_ON_MSVC on c file\n");
#endif
}
