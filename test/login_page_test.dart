// test/login_page_test.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_note/providers/auth_providers.dart' as app_auth;
import 'package:fridge_note/screens/login_page.dart';
import 'package:provider/provider.dart';

class MockAuthProvider extends ChangeNotifier implements app_auth.AuthProvider {
  bool loginCalled = false;

  @override
  User? get user => null;

  @override
  bool get isAuthenticated => false;

  @override
  bool get isAuthLoading => false;

  @override
  Future<String?> login(String email, String password) async {
    loginCalled = true;
    return null;
  }

  @override
  Future<void> logout() async {}

  @override
  Future<void> reloadUser() async {}

  @override
  Future<String?> resetPassword(String email) async {
    return null;
  }

  @override
  Future<String?> signUp(String email, String password, String username) async {
    return null;
  }
}

void main() {
  testWidgets('Login Sayfası UI elementleri doğru görüntülenmeli ve Login işlemi çalışmalı', (WidgetTester tester) async {
    final mockAuthProvider = MockAuthProvider();
    
    // 1. Login sayfasını test ortamında başlat
    await tester.pumpWidget(
      ChangeNotifierProvider<app_auth.AuthProvider>(
        create: (_) => mockAuthProvider,
        child: MaterialApp(
          home: const LoginPage(),
          routes: {
            '/home_screen': (context) => const Scaffold(body: Text('Home Screen')),
          },
        ),
      ),
    );

    // 2. Başlıkların ekranda olup olmadığını kontrol et
    expect(find.text('WELCOME TO FRIDGENOTE'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // 3. Email ve Şifre giriş alanlarının (TextField) varlığını kontrol et
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

    // 4. "Log in" butonunun varlığını kontrol et
    final loginButton = find.widgetWithText(ElevatedButton, 'Log in');
    expect(loginButton, findsOneWidget);

    // 5. "Sign up" ve "Forgot password?" butonlarının varlığını kontrol et
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);

    // 6. Etkileşim testi: Email ve şifre girip login butonuna basma
    await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@test.com');
    await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password');
    
    await tester.tap(loginButton);
    await tester.pump(); // Frame'i ilerlet

    // Login metodunun çağrıldığını doğrula
    expect(mockAuthProvider.loginCalled, true);
  });
}