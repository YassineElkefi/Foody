import 'package:flutter/material.dart';
import 'package:foody/features/auth/providers/auth_provider.dart';
import 'package:foody/features/auth/screens/welcome/welcome_screen.dart';
import 'package:foody/shared/widgets/styled_button_text.dart';
import 'package:foody/shared/widgets/styled_filled_button.dart';
import 'package:foody/shared/widgets/styled_text.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  

  @override
  Widget build(BuildContext context) {

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void handleLogout() {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.logout().then((_) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: StyledTitle('Home Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: StyledText('Welcome to Home Screen'),
              ),
              SizedBox(height: 20),
              StyledText('Username: ${authProvider.user!.username}'),
              StyledText('Email: ${authProvider.user!.email}'),
              StyledText('Role: ${authProvider.user!.role}'),
              StyledFilledButton(onPressed: handleLogout, child: StyledButtonText('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}