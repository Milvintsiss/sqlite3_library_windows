import 'dart:io';

import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_library_windows/sqlite3_library_windows.dart';

const int columnWidth = 15;

late final Database db;

void main() async {
  // Override the sqlite3 load config when OS is Windows
  open.overrideFor(OperatingSystem.windows, openSQLiteOnWindows);

  // If the database file doesn't exist, create it.
  File dbFile = await File('command_line_db.sqlite').create(recursive: true);

  // Open the database file
  db = sqlite3.open(dbFile.path);

  stdout.writeln('Type any SQL command to execute it.');
  stdout.writeln('You can exit at any moment by writing "exit" in the'
      ' command input.');
  stdout.writeln('You should start by creating a table, for example:');
  stdout.writeln('CREATE TABLE my_table '
      '(id INTEGER PRIMARY KEY, column_2 TEXT NOT NULL, column_3 TEXT);');
  stdout.writeln();
  while (true) {
    String sqlCommand = sqlCommandInput();
    if (sqlCommand == 'exit') break;

    try {
      if (sqlCommand.toUpperCase().trim().startsWith('SELECT')) {
        ResultSet rows = db.select(sqlCommand);
        if (rows.isEmpty) {
          stdout.writeln('Nothing matching query.');
          continue;
        }
        printRowLine(rows.first.keys.toList());
        rows.forEach((row) {
          printRowLine(row.values.map((e) => e.toString()).toList());
        });
      } else {
        db.execute(sqlCommand);
        stdout.writeln('${db.getUpdatedRows()} rows affected.');
      }
    } catch (e) {
      print(e);
    }
  }
}

String sqlCommandInput() {
  stdout.write('SQL command: ');
  return stdin.readLineSync() ?? '';
}

void printRowLine(List<String> row) {
  stdout.write('|');
  row.forEach((element) {
    if (element.length >= columnWidth)
      stdout.write('${element.substring(0, 9)}|');
    else
      stdout.write(' ' * ((columnWidth - element.length) / 2).round() +
          element +
          ' ' * ((columnWidth - element.length) ~/ 2).round() +
          '|');
  });
  stdout.writeln();
}
