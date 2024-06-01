import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  // var _counter = 0.0;
  var myFontSize = 30.0;
  late TextEditingController _controller1;
  late TextEditingController _controller2;
  var imageSource = "images/question-mark.png";
  late SharedPreferences savedData;

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    //Load the file for SharedPreferences, and pass it by the then() lambda function to savedData
    SharedPreferences.getInstance().then( (result){
      savedData = result;
      var loginName = result.getString("Login");
      if(loginName != null){
        _controller1.text = loginName;
      }
    });

  }

  @override
  void dispose() {
    super.dispose();
    _controller1.dispose();
    _controller2.dispose();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(controller: _controller1,
                decoration: InputDecoration(
                              hintText:"Type here",
                              border: OutlineInputBorder(),
                              labelText: "Login"
                  )),
            TextField(controller: _controller2, obscureText: true,
                decoration: const InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "Password",
                )),
            ElevatedButton(
                onPressed: buttonClicked,
                child: const Text("Login", style: TextStyle(fontSize: 25, color: Colors.blue))),
            Image.asset(imageSource, width:200, height:200)
          ],
        ),
      ),
    );
  }

  void buttonClicked (){
    // var snackBar = SnackBar( content: Text('Yay! A SnackBar!'),
    //     action:SnackBarAction( label:'Hide', onPressed: () {  } ));
    // ScaffoldMessenger.of(context).showSnackBar(snackBar);

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Save data'),
        content: const Text('Do you want to save your username and password?'),
        actions: <Widget>[
              ElevatedButton(
                  onPressed: (){
                    var login = _controller1.value.text;
                    var password = _controller2.value.text;
                    savedData.setString("Login", login);
                    Navigator.pop(context);
                    },
                  child: Text("OK")),
              FilledButton(onPressed: (){}, child: Text("Cancel"))
        ],
      ),
    );
  }


}
