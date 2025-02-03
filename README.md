[![CMake on multiple platforms](https://github.com/JanSimplify/KRDev/actions/workflows/cmake-multi-platform.yml/badge.svg)](https://github.com/JanSimplify/KRDev/actions/workflows/cmake-multi-platform.yml)

# KRDev

CMake跨平台开发中常用辅助函数，包含：

- 编译器特定的编译和链接选项设置函数；
- 辅助函数：设置常见编译警告、`Sanitizer`和`Coverage`选项；
- 获取Git提交信息。

测试于：

- Ubuntu：GCC，Clang；
- Windows：MSVC。

`macOS`、`Windows`下的`Clang`以及`CUDA`编译器等暂未测试。

## 使用方法

通过`FetchContent`导入项目：

```cmake
include(FetchContent)

FetchContent_Declare(
    KRDev
    GIT_REPOSITORY https://github.com/JanSimplify/KRDev.git
    GIT_TAG main
    SYSTEM
    FIND_PACKAGE_ARGS
)

FetchContent_MakeAvailable(KRDev)
```

使用`include()`导入需要使用的脚本文件：

```cmake
include(KRDevCompilerOption)
include(KRDevGitInfo)
```

## 编译器和链接器选项

`krdev_targets_set_compile_options()`可以为特定编译器以及语言设置相应的编译选项：

```cmake
krdev_targets_set_compile_options(
    TARGETS [targets...]
    [<PRIVATE|PUBLIC|INTERFACE>
        [MSVC_OPTIONS options1...]
        [GCC_C_OPTIONS options2...]
        [GCC_CXX_OPTIONS options3...]
        [CLANG_C_OPTIONS options4...]
        [CLANG_CXX_OPTIONS options5...]
    ]...
)
```

如下示例代码为不同编译器设置常见的警告选项：

```cmake
krdev_targets_set_compile_options(
    TARGETS <YourTargets>
    PRIVATE
        MSVC_OPTIONS /W4
        GCC_C_OPTIONS -Wall -Wextra
        GCC_CXX_OPTIONS -Wall -Wextra
        CLANG_C_OPTIONS -Wall -Wextra
        CLANG_CXX_OPTIONS -Wall -Wextra
)
```

`krdev_targets_set_link_options()`可以为特定编译器以及语言设置相应的链接选项：

```cmake
krdev_targets_set_link_options(
    TARGETS [targets...]
    [<PRIVATE|PUBLIC|INTERFACE>
        [MSVC_OPTIONS options1...]
        [GCC_C_OPTIONS options2...]
        [GCC_CXX_OPTIONS options3...]
        [CLANG_C_OPTIONS options4...]
        [CLANG_CXX_OPTIONS options5...]
    ]...
)
```

使用方法与`krdev_targets_set_compile_options()`类似。

## 辅助函数

`krdev_targets_set_development_options()`用于设置常见的编译警告选项：

```cmake
krdev_targets_set_development_options(
    TARGETS [targets...]
    [WARNING_AS_ERROR]
    [ERROR_AS_FATAL]
)
```

`krdev_targets_set_sanitizer()`设置消毒剂选项，目前支持`ADDRESS`和`UNDEFINED`，注意MSVC仅支持`ADDRESS`：

```cmake
krdev_targets_set_sanitizer(
    TARGETS [targets...]
    [ADDRESS]
    [UNDEFINED]
)
```

`krdev_targets_set_coverage()`设置代码覆盖率选项，在GCC和Clang下可用，MSVC中被简单忽略：

```cmake
krdev_targets_set_coverage(
  TARGETS [targets...]
)
```

## 获取Git提交信息

`krdev_get_git_description()`调用`git descript`获取相应的描述信息：

```cmake
krdev_get_git_description(
    OUTPUT_VARIABLE <outvar>
    WORKING_DIRECTORY <dir>
    [ALL]
    [DIRTY]
    [ALWAYS]
    [LONG]
)
```

相关选项请查阅`git`文档。

`krdev_get_git_hash()`调用`git rev-parse HEAD`获取提交HASH信息：

```cmake
krdev_get_git_hash(
    OUTPUT_VARIABLE <outvar>
    WORKING_DIRECTORY <dir>
)
```
