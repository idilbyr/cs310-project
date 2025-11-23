import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';

class AuthService {
  static const String _usersKey = 'users_list';

  // Save user to local storage

  Future<bool> signUp(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<User> users = await getUsers();

      // Check if user already exists

      if (users.any((u) => u.email == user.email || u.username == user.username)) {
        return false;
      }

      users.add(user);
      List<String> usersJson = users.map((u) => jsonEncode(u.toJson())).toList();
      await prefs.setStringList(_usersKey, usersJson);

      return true;
    } catch (e) {
      print('Error signing up: $e');
      return false;
    }
  }

  // Get all users

  Future<List<User>> getUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<String>? usersJson = prefs.getStringList(_usersKey);

      if (usersJson == null) return [];

      return usersJson.map((json) => User.fromJson(jsonDecode(json))).toList();
    } catch (e) {
      print('Error getting users: $e');
      return [];
    }
  }

  // validation
  Future<User?> login(String username, String password) async {
    try {
      List<User> users = await getUsers();

      for (User user in users) {
        if ((user.username == username || user.email == username) &&
            user.password == password) {
          return user;
        }
      }
      return null;
    } catch (e) {
      print('Error logging in: $e');
      return null;
    }
  }

  //  password reset
  Future<bool> resetPassword(String identifier, String newPassword) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      List<User> users = await getUsers();

      int userIndex = -1;
      for (int i = 0; i < users.length; i++) {
        if (users[i].username == identifier || users[i].email == identifier) {
          userIndex = i;
          break;
        }
      }

      if (userIndex == -1) return false;

      users[userIndex] = User(
        email: users[userIndex].email,
        username: users[userIndex].username,
        password: newPassword,
      );

      List<String> usersJson = users.map((u) => jsonEncode(u.toJson())).toList();
      await prefs.setStringList(_usersKey, usersJson);

      return true;
    } catch (e) {
      print('Error resetting password: $e');
      return false;
    }
  }
}