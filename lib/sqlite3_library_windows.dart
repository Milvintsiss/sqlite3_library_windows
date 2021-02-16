library sqlite3_library_windows;

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/foundation.dart';

///relative path to sqlite3 library when debuging
const sqlite3_windows_debug_libraryPath =
    'build\\flutter_assets\\packages\\sqlite3_library_windows\\sqlite3.dll';

///relative path in release bundle to sqlite3 library
const sqlite3_windows_release_libraryPath =
    'data\\flutter_assets\\packages\\sqlite3_library_windows\\sqlite3.dll';

///This function open SQLite3 in memory and return the associated DynamicLibrary
///object.
DynamicLibrary openSQLiteOnWindows() {
  final libraryFile = File(kDebugMode
      ? sqlite3_windows_debug_libraryPath
      : sqlite3_windows_release_libraryPath);
  print('SQLLite3 library PATH: ${libraryFile.absolute.path}');

  DynamicLibrary library;
  try {
    library = DynamicLibrary.open(libraryFile.path);

    print(_yellow("sqlite3 successfully loaded"));
  } catch (e) {
    try {
      print(_red("Fail loading sqlite3 from library file, "
          "trying loading from system..."));

      library = DynamicLibrary.open('sqlite3.dll');

      print(_yellow("sqlite3 successfully loaded"));
    } catch (e) {
      print(_red("Fail."));
    }
  }
  return library;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
