import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'create_fridge_screen.dart';
import 'fridge_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('APPNAME', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.person, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Arama Çubuğu (Görsel)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: const Text('Join via link', style: TextStyle(decoration: TextDecoration.underline)),
            ),

            const SizedBox(height: 40),

            // "My Fridge" Butonu - Screen 6'ya Gider
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, FridgeOverviewScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Wireframe rengi
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              child: const Text('My Fridge', style: TextStyle(fontSize: 20, color: Colors.white)),
            ),

            const SizedBox(height: 20),

            // "Create New" Butonu (+) - Screen 4'e Gider
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, CreateFridgeScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepPurple,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            ),
          ],
        ),
      ),

      // Wireframe'deki Alt Navigasyon Barı
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
    );
  }
}
