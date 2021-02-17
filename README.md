# SQLite3 library for windows

This package help you bundle SQLite3 library to your apps.

He was originally developed to use with moor but you can use it for others use cases that 
need SQLite3.

## How to use with Moor

Be sure to follow all the steps to migrate from moor_flutter to moor ffi 
([doc](https://moor.simonbinder.eu/docs/other-engines/vm/)).

Add an override for windows and give it the `openSQLiteOnWindows` function provided by the package:

    import 'dart:ffi';
    import 'dart:io';
    import 'package:sqlite3/sqlite3.dart';
    import 'package:sqlite3/open.dart';
	import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';
    
    void main() {
      open.overrideFor(OperatingSystem.windows, openSQLiteOnWindows);
    
      final db = sqlite3.openInMemory();
      db.dispose();
	  
	  runApp(MyApp());
    }

And... that's it! No need to provide your own sqlite3.dll file🙂

## I want to handle the SQLite3 library myself

No problem! You can use `getSQLiteLibraryPathOnWindows()` function to 
find the relative path of the SQLite3 library file.
If you want the absolute path you can do something like this 
`File(getSQLiteLibraryPathOnWindows()).absolute.path`