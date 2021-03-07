library sqlite3_library_windows;

import 'dart:ffi' show DynamicLibrary;

import 'dart:io' show Platform, File;

///relative path to SQLite3 library file
const sqlite3_windows_libraryPath =
    '\\data\\flutter_assets\\packages\\sqlite3_library_windows\\sqlite3.dll';

///This function open SQLite3 in memory and return the associated DynamicLibrary.
///Return null if app fail to open SQLite3.
DynamicLibrary? openSQLiteOnWindows() {
  DynamicLibrary? library;

  String executableDirectoryPath =
      File(Platform.resolvedExecutable).parent.path;
  print('executableDirectoryPath: $executableDirectoryPath');
  try {
    String sqliteLibraryPath =
        executableDirectoryPath + sqlite3_windows_libraryPath;
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
      print(_red("Fail to load SQLite3."));
    }
  }
  return library;
}

String _red(String string) => '\x1B[31m$string\x1B[0m';

String _yellow(String string) => '\x1B[32m$string\x1B[0m';
