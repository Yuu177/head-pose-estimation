cmake_minimum_required(VERSION 3.2)
project(CppDemo)
add_definitions(-std=c++11)

# 在 cmake 配置中，你需要加入下面这两句来完成 conan 的基本配置
include(${CMAKE_BINARY_DIR}/conanbuildinfo.cmake)
conan_basic_setup()

# DCMAKE_EXPORT_COMPILE_COMMANDS=ON 生成插件 clangd 依赖的 compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
if(CMAKE_EXPORT_COMPILE_COMMANDS)
    # 解决交叉编译 clangd 插件会提示找不到标准库的头文件
    # 因为交叉编译使用的是交叉编译器，有自己的标准库头文件目录
    set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
endif()

add_executable(CppDemo main.cpp)

# 变量 CONAN_LIBS 中包含了你用到的所有 conan 包中含有的 libs 的名称，
# 你可以直接使用这个变量，若你知道你该 link 哪些 libs，当然你也可以自己写 libs 名称。
# 一般推荐自己写 libs 名称，这样会避免链接了不必要的 libs
target_link_libraries(CppDemo ${CONAN_LIBS})
