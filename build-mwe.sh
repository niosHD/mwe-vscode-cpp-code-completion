#!/bin/sh

git submodule update --recursive --init

# build the fmt library
mkdir -p _build_fmt
cd _build_fmt
cmake -DFMT_TEST=false ../fmt
cmake --build .

# configure and build a simple test program
cd ..
mkdir -p _build_test
cd _build_test
cmake -DFMT_DIR=$(pwd)/../_build_fmt -DCMAKE_EXPORT_COMPILE_COMMANDS=true ../find-package-test/
cmake --build .

# open the test program in vscode
cd ..
code -n find-package-test
