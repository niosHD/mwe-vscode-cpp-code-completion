cmake_minimum_required(VERSION 2.8.12)

project(fmt-test)

find_package(FMT REQUIRED)

add_executable(library-test main.cpp)
target_link_libraries(library-test fmt::fmt)
