import 'package:flutter/material.dart';
import 'package:foody/features/auth/providers/auth_provider.dart';
import 'package:foody/features/auth/screens/welcome/welcome_screen.dart';
import 'package:foody/shared/widgets/styled_button_text.dart';
import 'package:foody/shared/widgets/styled_filled_button.dart';
import 'package:foody/shared/widgets/styled_text.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        title: Text('Admin Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              StyledTitle('Admin Screen'),
              const Spacer(),
              const StyledHeading('Welcome Admin!'),
              const Spacer(),
              StyledFilledButton( onPressed: handleLogout, child: const StyledButtonText('Logout')),
              const Spacer(),
            ],
          )
        ),
      ),
    );
  }
}