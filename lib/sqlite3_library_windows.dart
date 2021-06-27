/// Flutter package to bundle sqlite3 library to your windows apps
library sqlite3_library_windows;

import 'dart:ffi' show DynamicLibrary;

import 'absolute_path_to_sqlite.dart';

/// This function open SQLite3 in memory and return the associated DynamicLibrary.
DynamicLibrary openSQLiteOnWindows() {
  late DynamicLibrary library;
  try {
    library = DynamicLibrary.open(sqlite3WindowsLibraryPath);

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(e);
      print(_red("Failed to load SQLite3 from library file, "
          "trying loading from system..."));

      library = DynamicLibrary.open('sqlite3.dll');

      print(_yellow("SQLite3 successfully loaded"));
    } catch (e) {
      print(e);
      print(_red("Failed to load SQLite3."));
    }
  }
  return library;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
