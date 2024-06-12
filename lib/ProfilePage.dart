
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'DataRepository.dart';

//StatefulWidget means widget with variables
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  static late TextEditingController firstNameController;
  static late TextEditingController lastNameController;
  static late TextEditingController phoneController;
  static late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    loadData();
  }

  @override
  void dispose() {
    DataRepository.saveData();
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  //Method to load saved data from EncryptedSharedPreferences
  Future<void> loadData() async {
    // Get the saved data for text fields
    DataRepository.firstName = await DataRepository.savedData.getString("firstName");
    DataRepository.lastName = await DataRepository.savedData.getString("lastName");
    DataRepository.phone = await DataRepository.savedData.getString("phone");
    DataRepository.email = await DataRepository.savedData.getString("email");

    setState(() {
      // Updating the TextEditingControllers with the retrieved data
      DataRepository.loadData();

      // Show a welcome SnackBar
      var snackBar = SnackBar(
          content: Text("Welcome back ${DataRepository.loginName}"),
          duration: const Duration(seconds: 5),
      );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
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
            Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 10), child:
              TextField(controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "First Name"
                ))
            ),
            Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 10), child:
              TextField(controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "Last Name"
                ))
            ),
            Row(children: <Widget>[
                Flexible(
                  child: Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 10), child:
                            TextField(controller: phoneController,
                              decoration: const InputDecoration(
                                hintText:"Type here",
                                border: OutlineInputBorder(),
                                labelText: "Phone Number",
                            )),
                          )
                ),
                IconButton(onPressed: () {
                  _launchPhoneDialer();
                }, icon: const Icon(Icons.phone)),
                IconButton(onPressed: () {
                  _launchMessageApp();
                }, icon: const Icon(Icons.message))
            ]),
            Row(children: <Widget>[
              Flexible(
                  child: Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 10), child:
                  TextField(controller: emailController,
                      decoration: const InputDecoration(
                        hintText:"Type here",
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                      )),
                  )
              ),
                IconButton(onPressed: () {
                  _launchEmailApp();
                }, icon: const Icon(Icons.email))
            ]),
        ]),
      ),
    );
  }

  void _launchPhoneDialer() async {
    final phoneNumber = phoneController.text;
    final url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showAlertDialog();
    }
  }

  void _launchMessageApp() async {
    final phoneNumber = phoneController.text;
    final url = 'sms:$phoneNumber';

    if (await canLaunch(url)) {
    await launch(url);
    } else {
    _showAlertDialog();
    }
  }

  void _launchEmailApp() async {
    final email = emailController.text;
    final url = 'mailto:$email';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      _showAlertDialog();
    }
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Could not launch, the URL is not supported on this device.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          ]);
      });
  }



}