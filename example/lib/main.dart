/// This example show you how to use the openSQLiteOnWindows function
///
/// It also show you how to create your database file and how to execute simple
/// SQL functions.
///
/// Here the table used have only one column and we use only one row to store
/// a count value. But you can use all SQLite possibilities and build complex
/// tables and queries, the only limitations are on SQLite side.
/// If you have a more relevant example in mind like TodoList app or other feel
/// free to do a pull request :)

import 'dart:io' show File;
import 'package:path_provider/path_provider.dart'
    show getApplicationSupportDirectory;

import 'package:flutter/material.dart';

import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';

late final Database db;

Future<void> main() async {
  // Override the sqlite3 load config when OS is Windows
  open.overrideFor(OperatingSystem.windows, openSQLiteOnWindows);

  // Folder where the database will be stored
  final dbFolder = await getApplicationSupportDirectory();

  // If the database file doesn't exist, create it.
  File dbFile =
      await File(dbFolder.path + "\\sqlite3_library_windows_example\\db")
          .create(recursive: true);

  // Open the database file
  db = sqlite3.open(dbFile.path);

  // Create 'count' table if the table doesn't already exist
  db.execute('CREATE TABLE IF NOT EXISTS '
      'count (count_value INTEGER NOT NULL);');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() => _counter++);
    _updateCounterInDatabase();
  }

  void _getCounterFromDatabase() {
    var values = db.select('SELECT count_value FROM count;');
    if (values.isNotEmpty) _counter = values.first['count_value'];
  }

  void _updateCounterInDatabase() {
    db.execute('DELETE FROM count;');
    db.execute('INSERT INTO count (count_value) VALUES ($_counter);');
  }

  @override
  void initState() {
    super.initState();
    _getCounterFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
