

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:test_flutter/ProfilePage.dart';

class DataRepository {
  static String loginName = "";
  static String passwd = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";
  static EncryptedSharedPreferences savedData = EncryptedSharedPreferences();

  static void loadData() {
    ProfilePageState.firstNameController.text = firstName;
    ProfilePageState.lastNameController.text = lastName;
    ProfilePageState.phoneController.text = phone;
    ProfilePageState.emailController.text = email;
  }

  static void saveData() {
    savedData.setString("firstName", ProfilePageState.firstNameController.value.text);
    savedData.setString("lastName", ProfilePageState.lastNameController.value.text);
    savedData.setString("phone", ProfilePageState.phoneController.value.text);
    savedData.setString("email", ProfilePageState.emailController.value.text);
  }

}