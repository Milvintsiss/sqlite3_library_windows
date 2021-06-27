/// Flutter package to bundle sqlite3 library to your windows apps
library sqlite3_library_windows;

import 'dart:ffi' show DynamicLibrary;
import 'dart:io' show Platform, File;

/// Relative path to SQLite3 dll library file
const sqlite3WindowsLibraryPath =
    '\\data\\flutter_assets\\packages\\sqlite3_library_windows\\sqlite3.dll';

/// This function open SQLite3 in memory and return the associated DynamicLibrary.
DynamicLibrary openSQLiteOnWindows() {
  late DynamicLibrary library;

  String executableDirectoryPath =
      File(Platform.resolvedExecutable).parent.path;
  print('executableDirectoryPath: $executableDirectoryPath');
  try {
    String sqliteLibraryPath =
        executableDirectoryPath + sqlite3WindowsLibraryPath;
    print('SQLite3LibraryPath: $sqliteLibraryPath');

    library = DynamicLibrary.open(sqliteLibraryPath);

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
