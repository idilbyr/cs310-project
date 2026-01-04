// test/user_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_note/models/user.dart';
void main() {
  group('User Model Tests (Unit Test)', () {
    // Testlerde kullanacağımız örnek veriler
    const email = 'test@student.sabanciuniv.edu';
    const username = 'cs310_student';
    const password = 'securePassword123';

    test('User sınıfı verilen değerlerle doğru oluşturulmalı', () {
      final user = User(
        email: email,
        username: username,
        password: password,
      );

      expect(user.email, email);
      expect(user.username, username);
      expect(user.password, password);
    });

    test('toJson() metodu User objesini doğru bir Map yapısına çevirmeli', () {
      final user = User(
        email: email,
        username: username,
        password: password,
      );

      final jsonMap = user.toJson();

      expect(jsonMap['email'], email);
      expect(jsonMap['username'], username);
      expect(jsonMap['password'], password);
    });

    test('fromJson() metodu Map verisini doğru bir User objesine çevirmeli', () {
      final jsonMap = {
        'email': email,
        'username': username,
        'password': password,
      };

      final user = User.fromJson(jsonMap);

      expect(user.email, email);
      expect(user.username, username);
      expect(user.password, password);
    });
  });
}