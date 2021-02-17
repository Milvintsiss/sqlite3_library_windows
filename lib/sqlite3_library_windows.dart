library sqlite3_library_windows;

import 'dart:ffi';

import 'package:flutter/foundation.dart';

///relative path to SQLite3 library file when debuging
const sqlite3_windows_debug_libraryPath =
    'build\\flutter_assets\\packages\\sqlite3_library_windows\\sqlite3.dll';

///relative path in release bundle to SQLite3 library file
const sqlite3_windows_release_libraryPath =
    'data\\flutter_assets\\packages\\sqlite3_library_windows\\sqlite3.dll';

///This function open SQLite3 in memory and return the associated DynamicLibrary
///object.
DynamicLibrary openSQLiteOnWindows() {
  DynamicLibrary library;
  try {
    library = DynamicLibrary.open(getSQLiteLibraryPathOnWindows());

    print(_yellow("SQLite3 successfully loaded"));
  } catch (e) {
    try {
      print(_red("Fail loading SQLite3 from library file, "
          "trying loading from system..."));

      library = DynamicLibrary.open('sqlite3.dll');

      print(_yellow("SQLite3 successfully loaded"));
    } catch (e) {
      print(_red("Fail loading SQLite3."));
    }
  }
  return library;
}

///return path of SQLite3 library file
String getSQLiteLibraryPathOnWindows() {
  return kDebugMode
      ? sqlite3_windows_debug_libraryPath
      : sqlite3_windows_release_libraryPath;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
