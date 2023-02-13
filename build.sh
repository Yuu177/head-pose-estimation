#!/bin/bash
set -e
set -x

rm -rf build
mkdir build
pushd build

# -s 为 --settings 简写
conan install ../conanfile.txt --build=missing -s compiler.libcxx=libstdc++11
cmake .. -D CMAKE_BUILD_TYPE=RELEASE
make -j16

# LD_LIBRARY_PATH 告诉 loader 在哪些目录中可以找到共享库。可以设置多个搜索目录，这些目录之间用冒号分隔开
export LD_LIBRARY_PATH=`pwd`/runtime:${LD_LIBRARY_PATH}

# 在根目录下运行
cd ..
./build/bin/CppDemo
