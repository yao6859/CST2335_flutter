

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

class DataRepository {
  static String loginName = "";
  static String passwd = "";
  static String firstName = "";
  static String lastName = "";
  static String phone = "";
  static String email = "";
  static EncryptedSharedPreferences savedData = EncryptedSharedPreferences();
}