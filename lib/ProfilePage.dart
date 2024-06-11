
import 'package:flutter/material.dart';

import 'DataRepository.dart';

//StatefulWidget means widget with variables
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.title});
  final String title;

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;

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
      if (DataRepository.firstName != "") {
        firstNameController.text = DataRepository.firstName;
      }
      if (DataRepository.lastName != "") {
        lastNameController.text = DataRepository.lastName;
      }
      if (DataRepository.phone != "") {
        phoneController.text = DataRepository.phone;
      }
      if (DataRepository.email != "") {
        emailController.text = DataRepository.email;
      }

      // Show a welcome SnackBar
      var snackBar = SnackBar(
          content: Text("Welcome back ${DataRepository.loginName}"),
          duration: const Duration(seconds: 5),
      );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  //Method to save data to EncryptedSharedPreferences
  Future<void> saveData() async {

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
              TextField(controller: firstNameController,
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
                IconButton(onPressed: () {}, icon: const Icon(Icons.phone)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.message))
            ]),
            Row(children: <Widget>[
              Flexible(
                  child: Padding(padding: const EdgeInsets.fromLTRB(10, 0, 0, 10), child:
                  TextField(controller: phoneController,
                      decoration: const InputDecoration(
                        hintText:"Type here",
                        border: OutlineInputBorder(),
                        labelText: "Email Address",
                      )),
                  )
              ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.email))
            ]),
        ]),
      ),
    );
  }
}