// lib/screens/settings_profile_screen.dart

import 'package:flutter/material.dart';
import '../utils/constants.dart';

// Model Sınıfı
class FridgeModel {
  final String id;
  final String name;
  FridgeModel({required this.id, required this.name});
}

class SettingsProfileScreen extends StatefulWidget {
  static const routeName = '/settings';

  const SettingsProfileScreen({super.key});

  @override
  State<SettingsProfileScreen> createState() => _SettingsProfileScreenState();
}

class _SettingsProfileScreenState extends State<SettingsProfileScreen> {
  bool _notificationsEnabled = true;

  // Dinamik Kaldırma için state içinde tutulan liste
  List<FridgeModel> _savedFridges = [
    FridgeModel(id: 'f1', name: 'Ana Mutfak'),
    FridgeModel(id: 'f2', name: 'Ofis Buzdolabı'),
    FridgeModel(id: 'f3', name: 'Yazlık Ev'),
  ];

  void _removeFridge(String id) {
    setState(() {
      _savedFridges.removeWhere((fridge) => fridge.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Buzdolabı listeden kaldırıldı.')),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        // Images Gereksinimi (Örn: Network Image)
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          backgroundColor: AppColors.background,
        ),
        const SizedBox(height: 10),
        Text('User Name', style: AppTextStyles.title),
        Text('email@example.com', style: AppTextStyles.body),
      ],
    );
  }

  Widget _buildSettingsTile({
    required String title,
    IconData? icon,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: AppColors.primary) : null,
      title: Text(title, style: AppTextStyles.body),
      trailing: trailing,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar / Profil'),
        backgroundColor: AppColors.primary,
      ),
      body: ListView(
        padding: AppPaddings.screenPadding,
        children: <Widget>[
          _buildProfileHeader(),
          const Divider(height: 30),

          _buildSettingsTile(
            title: 'Bildirimler',
            icon: Icons.notifications,
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: AppColors.primary,
            ),
          ),

          const Divider(),

          Text('Kaydedilen Buzdolapları',
              style: AppTextStyles.title.copyWith(fontSize: 18)),
          const SizedBox(height: 10),

          // Card & List ve Dinamik Kaldırma Gereksinimi
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _savedFridges.length,
            itemBuilder: (ctx, index) {
              final fridge = _savedFridges[index];
              return Card(
                elevation: 2,
                margin: AppPaddings.verticalSpace,
                child: ListTile(
                  leading: const Icon(Icons.kitchen, color: AppColors.secondary),
                  title: Text(fridge.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_forever, color: AppColors.error),
                    onPressed: () => _removeFridge(fridge.id), // Kaldırma işlevi
                  ),
                ),
              );
            },
          ),

          const Divider(height: 30),

          // Hesap Yönetimi
          _buildSettingsTile(
            title: 'Şifre Değiştir',
            icon: Icons.lock,
            onTap: () {},
          ),
          _buildSettingsTile(
            title: 'Hesabı Sil',
            icon: Icons.person_remove,
            onTap: () {},
          ),
          _buildSettingsTile(
            title: 'Çıkış Yap',
            icon: Icons.logout,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}