
import 'package:floor/floor.dart';

import 'ToDoItem.dart';

@dao
abstract class ToDoItemDao {
  @Query('SELECT * FROM ToDoItem')
  Future<List<ToDoItem>> findAllToDoItem();

  @Query('SELECT * FROM ToDoItem WHERE id = :id')
  Stream<ToDoItem?> findToDoItemById(int id);

  @insert
  Future<void> insertToDoItem(ToDoItem todo);

  @delete
  Future<int> deleteToDoItem(ToDoItem todo);
}