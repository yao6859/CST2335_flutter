
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:test_flutter/ToDoItem.dart';
import 'ToDoItemDao.dart';

part 'ToDoDatabase.g.dart';

@Database(version: 1, entities: [ToDoItem])
abstract class ToDoDatabase extends FloorDatabase {
  ToDoItemDao get toDoItemDao;
}