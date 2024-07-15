import 'package:flutter/material.dart';
import 'package:test_flutter/ToDoItem.dart';

import 'ToDoDatabase.dart';
import 'ToDoItemDao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var isChecked = false;
  late TextEditingController _controller;
  late TextEditingController _controller2;
  var words = <ToDoItem>[];
  late ToDoItemDao toDoItemDao;
  ToDoItem? selectedItem;


  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller2 = TextEditingController();
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final database = await $FloorToDoDatabase.databaseBuilder('todo_database.db').build();
    toDoItemDao = database.toDoItemDao;
    // retrieve items from database
    toDoItemDao.findAllToDoItem().then((listOfItem) {
      setState(() {
        words.addAll(listOfItem);
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Widget _toDoList() { // This function returns the to do item structure from lab7
    return Center(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(//To contain the TextField and Button in the same row
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Type here",
                          border: OutlineInputBorder(),
                          labelText: "Enter a to-do item",
                        ),
                      ),
                    ),
                    ElevatedButton(
                        child: const Text("Add"),
                        onPressed: () {
                          if(_controller.value.text != "") {
                            setState(() {
                              var newItem = _controller.value.text;
                              // create the object of type ToDoItem, using dynamically generated id
                              var todo = ToDoItem(ToDoItem.ID++, newItem);
                              // add the new item to page
                              words.add(todo);
                              // add the new item to database
                              toDoItemDao.insertToDoItem(todo);

                              _controller.clear();
                            });
                          }
                        }),
                  ]),
            ),

            //The if statement to display the text when the array is empty
            if (words.isEmpty)
              const Text(
                "There are no items in the list",
                style: TextStyle(fontSize: 20),
              ),
            // Use Expanded to contain ListView in the Column container, so it can take as much space as possible
            Expanded(
                child: ListView.builder(
                  itemCount: words.length,
                  itemBuilder: (context, rowNum) {
                    return GestureDetector(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                                "Row number:  $rowNum",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                )),
                            Text(
                                words[rowNum].item,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                )),
                          ]),
                      onTap: (){
                        selectedItem = words[rowNum];
                        setState(() {
                          _detailsPage();
                        });
                      },
                      onLongPress: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete Item'),
                            content: const Text('Do you want to delete this to-do item?'),
                            actions: <Widget>[
                              ElevatedButton(onPressed: () {
                                setState(() {
                                  // remove form database
                                  toDoItemDao.deleteToDoItem(words[rowNum]);
                                  // remove from page
                                  words.removeAt(rowNum);
                                });
                                Navigator.pop(context);
                              },
                                  child: const Text("Yes")
                              ),
                              ElevatedButton(onPressed: () {
                                Navigator.pop(context);
                              },
                                  child: const Text("No")
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                )),
          ]),
    );
  }

  // The function of constructing the detail page of a to-do item
  Widget _detailsPage() {
    if(selectedItem != null) {
      return Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                  child:
                  Text("Details of the To-Do Item",
                      style: TextStyle(fontSize: 30)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 30, 30),
                  child:
                  Text("Item ID: ${selectedItem!.id}", style: const TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 30, 30),
                  child:
                  Text("Item Name: ${selectedItem!.item}", style: const TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 50, 30, 30),
                  child:
                  FilledButton(onPressed: () {
                        setState(() {
                          // remove form database
                          toDoItemDao.deleteToDoItem(selectedItem!);
                          // another way to remove the selected item from the page
                          words.removeWhere((item) => item.id == selectedItem!.id);
                          // Set selectedItem back to null:
                          // so if it is in landscape model, the right side display the text "Select an item...",
                          // if it is in portrait model, the screen switch back to to-do list page
                          selectedItem = null;
                        });
                      },
                      child: const Text("Delete")
                  )
                )
              ])
      );
    }
    else {
      return const Center(
        child: Text(
          "Select an item to view the details",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      );
    }
  }

  // The function to return different layouts respond to the screen model
  Widget responsiveLayout() {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    if ((width > height) && (width > 720)) { // Landscape model, viewList on the left side, detail page on the right side
      return Row(children:[
        Expanded(child: _toDoList()),
        Expanded(child: _detailsPage())
      ]);
    }
    else {// Portrait model
      if(selectedItem == null) {
        return _toDoList();
      }
      else {
        return _detailsPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child:
                OutlinedButton(onPressed: () {
                  setState(() {
                    selectedItem = null;
                  });
                }, child: const Text("Back"))
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: responsiveLayout()
    );
  }

}