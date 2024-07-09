
import 'package:floor/floor.dart';

@entity
class ToDoItem {
  static int ID = 1;

  @primaryKey
  final int id;

  final String item;

  ToDoItem(this.id, this.item)
  {
    if(id > ID) {
      ID = id + 1;
    }
  }
}
