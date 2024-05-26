import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
  var myFontSize = 20.0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double radius = screenWidth * 0.1;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("BROWSE CATEGORIES",
              style: TextStyle(fontSize: 30.0,
                     fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                "Not sure about exactly which recipe you're looking for? Do a research, or dive into our most popular categories.",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
            const Text("BY MEAT",
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: radius,
                      backgroundImage: const AssetImage("images/beef.jpg"),
                    ),
                    const Text("BEEF",
                      style: TextStyle(fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,),
                    ),
                  ]),
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/chicken.jpg"),
                      ),
                      const Text("CHICKEN",
                        style: TextStyle(fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/pork.jpg"),
                      ),
                      const Text("PORK",
                        style: TextStyle(fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/seafood.jpg"),
                      ),
                      const Text("SEAFOOD",
                        style: TextStyle(fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,),
                      ),
                    ]),
          ],
        ),
            const Text("BY COURSE",
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/main_dish.jpg"),
                      ),
                      const Text("Main Dishes",
                        style: TextStyle(fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/salad.jpg"),
                      ),
                      const Text("Salad Recipes",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/side_dish.jpg"),
                      ),
                      const Text("Side Dishes",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/crockpot.jpg"),
                      ),
                      const Text("Crockpot",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ],
            ),
            const Text("BY DESSERT",
              style: TextStyle(fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/ice_cream.jpg"),
                      ),
                      const Text("Ice Cream",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/brownie.jpg"),
                      ),
                      const Text("Brownies",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/pie.jpg"),
                      ),
                      const Text("Pies",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      CircleAvatar(
                        radius: radius,
                        backgroundImage: const AssetImage("images/cookie.jpg"),
                      ),
                      const Text("Cookies",
                        style: TextStyle(fontSize: 15.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
              ],
            ),
      ]),
    ));
  }
}
