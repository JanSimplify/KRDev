# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright (c) 2025 JanSimplify

include(KRDevGitInfo)

krdev_get_git_description(
    OUTPUT_VARIABLE git_desc
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
    ALWAYS
    LONG
)

message("git_desc: " "${git_desc}")

krdev_get_git_hash(
    OUTPUT_VARIABLE git_hash
    WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}"
)

message("git_hash: " "${git_hash}")
