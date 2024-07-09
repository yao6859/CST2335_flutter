import 'package:flutter/material.dart';

import 'ToDoDatabase.dart';
import 'ToDoItem.dart';
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
  late ToDoItemDao toDoItemDao;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
      ));
  }

  List<ToDoItem> words = [ ];
  // var wordsArray = <String>[ ]; //Another way to create a array

}