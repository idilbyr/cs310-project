// test/login_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fridge_note/screens/login_page.dart';

void main() {
  testWidgets('Login Sayfası UI elementleri doğru görüntülenmeli', (WidgetTester tester) async {
    // 1. Login sayfasını test ortamında başlat
    await tester.pumpWidget(const MaterialApp(
      home: LoginPage(),
    ));

    // 2. Başlıkların ekranda olup olmadığını kontrol et
    expect(find.text('WELCOME TO FRIDGENOTE'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    // 3. Email ve Şifre giriş alanlarının (TextField) varlığını kontrol et
    // 'Email' ve 'Password' etiketine sahip TextFormField var mı?
    expect(find.widgetWithText(TextFormField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'Password'), findsOneWidget);

    // 4. "Log in" butonunun varlığını kontrol et
    expect(find.widgetWithText(ElevatedButton, 'Log in'), findsOneWidget);

    // 5. "Sign up" ve "Forgot password?" butonlarının varlığını kontrol et
    expect(find.text('Sign up'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });
}