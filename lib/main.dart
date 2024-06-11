
import 'package:flutter/material.dart';
import 'package:test_flutter/DataRepository.dart';
import 'package:test_flutter/ProfilePage.dart';

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
      title: 'Named Routes Demo',
      initialRoute: '/pageOne',
      routes: {
        '/pageOne': (context) => const MyHomePage(title: 'Login Page'),
        '/pageTwo': (context) {return const ProfilePage(title: "Profile Page");}
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
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

  @override
  void initState() {
    super.initState();
    _controller1 = TextEditingController();
    _controller2 = TextEditingController();
    loadData();
  }

  //Method to load saved data from EncryptedSharedPreferences
  Future<void> loadData() async {
    // Get the saved data for login and password
    DataRepository.loginName = await DataRepository.savedData.getString("Login");
    DataRepository.passwd = await DataRepository.savedData.getString("Password");

    setState(() {
      // Updating the TextEditingControllers with the retrieved data
      if (DataRepository.loginName != "") {
        _controller1.text = DataRepository.loginName;
      }
      if (DataRepository.passwd != "") {
        _controller2.text = DataRepository.passwd;
      }

      // Show a SnackBar that inform user the saved data is load and ask if they want to clear the data
      if (DataRepository.loginName != "" || DataRepository.passwd != "") {
        var snackBar = SnackBar(
            content: const Text("Your login and password are loaded!"),
            duration: const Duration(seconds: 6),
            action: SnackBarAction(label: "Clear saved data", onPressed: () {
              DataRepository.savedData.clear();
              _controller1.clear();
              _controller2.clear();
            })
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
            Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 0), child:
              TextField(controller: _controller1,
                  decoration: const InputDecoration(
                              hintText:"Type here",
                              border: OutlineInputBorder(),
                              labelText: "Login"
                  ))
            ),
            Padding(padding: const EdgeInsets.fromLTRB(10, 10, 10, 10), child:
              TextField(controller: _controller2, obscureText: true,
                  decoration: const InputDecoration(
                              hintText:"Type here",
                              border: OutlineInputBorder(),
                              labelText: "Password",
                ))
            ),
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
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Save Data'),
        content: const Text('Do you want to save your username and password?', style: TextStyle(fontSize: 20)),
        actions: <Widget>[
              FilledButton(
                  onPressed: () {
                    DataRepository.savedData.setString("Login", _controller1.value.text);
                    DataRepository.savedData.setString("Password", _controller2.value.text);
                    Navigator.pop(context);
                    if (_controller1.value.text == 'yi' && _controller2.value.text == 'password') {
                      Navigator.pushNamed(context, '/pageTwo');
                    }
                  },
                  child: const Text("YES")),
              FilledButton(
                  onPressed: (){
                    // Clear data saved in the EncryptedSharedPreferences
                    Navigator.pop(context);
                    if (_controller1.value.text == 'yi' && _controller2.value.text == 'password') {
                      Navigator.pushNamed(context, '/pageTwo');
                    }
                    DataRepository.savedData.clear();
                    },
                  child: const Text("NO"))
        ],
      ),
    );
  }


}
