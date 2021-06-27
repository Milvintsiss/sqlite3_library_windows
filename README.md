[![pub package](https://img.shields.io/pub/v/sqlite3_library_windows)](https://pub.dev/packages/camera)
# SQLite3 library for windows

This package help you bundle SQLite3 library to your apps.

It can be used with packages like Moor to make the SQLite opening process easier (See: [How to use with Moor](#how-to-use-with-moor)). 

## How to use

Add an override for windows and give it the `openSQLiteOnWindows` function provided by the package:

```dart
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';
 
late final Database db;

void main() {
  open.overrideFor(OperatingSystem.windows, openSQLiteOnWindows);
    
  // For database file creation and more please see the example
  db = sqlite3.open([YOUR_DB_FILE]);
     
  runApp(MyApp());
}
```

And... that's it! No need to provide your own sqlite3.dll file 🙂

## How to use with Moor

Be sure to follow all the steps to migrate from moor_flutter to moor ffi ([docs](https://moor.simonbinder.eu/docs/other-engines/vm/)).

Then add an override for windows and give it the `openSQLiteOnWindows` function provided the package:

```dart
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';
 
void main() {
  open.overrideFor(OperatingSystem.windows, openSQLiteOnWindows);

  final db = sqlite3.openInMemory();
  db.dispose();
     
  runApp(MyApp());
}
```
