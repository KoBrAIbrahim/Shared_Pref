import 'package:flutter/material.dart';
import 'package:main_app/contraller/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({super.key, required this.username});

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setBool('isDarkMode', false);
    await prefs.remove('username');
    await prefs.remove('password');
    await prefs.remove('remember');

    final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
    themeNotifier.setDefult();
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
        actions: [
          Row(
            children: [
              Icon(Icons.light_mode),
              Switch(
                value: themeNotifier.isDarkMode,
                onChanged: (value) {
                  themeNotifier.toggleTheme();
                },
              ),
              Icon(Icons.dark_mode),
              IconButton(
                icon: Icon(Icons.logout),
                tooltip: "Logout",
                onPressed: () => _logout(context),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Text("🎉 Welcome, $username!", style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
