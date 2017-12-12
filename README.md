vscode C++ Code Completion via Compilation Database
===================================================

Minimal working example which sets up a simple C++ application and vscode to test code completion.

Usage
-----
* execute `build-mwe.sh` which performs the following steps
  * update the git submodule
  * builds the [fmt](https://github.com/fmtlib/fmt) Library
  * builds a very simple test
  * and opens a new vscode window with the test program and configured compilation database
* open the `main.cpp` file and see if clang-based code completion works
* close vscode, modify `_build_test/compile_commands.json`, open vscode and check again

Problem (vscode 1.18.1, cpptools 0.14.4)
----------------------------------------
Clang-based code completion does not work because `-isystem` is not processed correctly (despite [#156](https://github.com/Microsoft/vscode-cpptools/issues/156)).

The problem seems to be that `-isystem` is handled exactly like `-I` meaning that the parser is expecting arguments like `-I/path/to/directory` and `-isystem/path/to/directory`. For `-I` that works since cmake generates the arguments in this form. However, for `-isystem`, cmake is generating the entries in the compilation database as `-isystem /path/to/directory` (note the space between `-isystem` and the path) which is not understood by the cpptools.

It would in general be a good idea to support both forms (with and without space between the flag and the path) for `-I` and `-isystem` since gcc and clang also accept them.
