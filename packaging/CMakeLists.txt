# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright (c) 2025 JanSimplify

#=============================
# Variables
#=============================

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

set(config_install_dir "${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}")

set(autogen_cmake_dir "${autogen_root}/cmake")
set(autogen_package_config "${autogen_cmake_dir}/${PROJECT_NAME}Config.cmake")
set(autogen_package_version_file "${autogen_cmake_dir}/${PROJECT_NAME}ConfigVersion.cmake")

set(script_files
    "${PROJECT_SOURCE_DIR}/cmake/KRDevCompilerOption.cmake"
    "${PROJECT_SOURCE_DIR}/cmake/KRDevGitInfo.cmake"
    "${PROJECT_SOURCE_DIR}/cmake/KRDevHelper.cmake"
)

#=============================
# Package version
#=============================

write_basic_package_version_file(
    "${autogen_package_version_file}"
    VERSION "${PROJECT_VERSION}"
    COMPATIBILITY "AnyNewerVersion"
)

#=============================
# Package config
#=============================

configure_package_config_file(
    "ProjectConfig.cmake.in"
    "${autogen_package_config}"
    INSTALL_DESTINATION "${config_install_dir}"
    PATH_VARS config_install_dir
    NO_SET_AND_CHECK_MACRO
    NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

install(
    FILES
        "${autogen_package_config}"
        "${autogen_package_version_file}"
        ${script_files}
    DESTINATION "${config_install_dir}"
    COMPONENT "${development_component}"
)
