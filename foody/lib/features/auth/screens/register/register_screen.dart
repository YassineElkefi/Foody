import 'package:flutter/material.dart';
import 'package:foody/features/auth/providers/auth_provider.dart';
import 'package:foody/features/home/screens/home_screen.dart';
import 'package:foody/shared/widgets/styled_button_text.dart';
import 'package:foody/shared/widgets/styled_filled_button.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _handleRegister() async{
    if (_formkey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      final username = _usernameController.text;
      try {
        final user = await authProvider.register(username, email, password);
        
        // Check if widget is still mounted and user is authenticated
        if (context.mounted && user != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const HomeScreen()),
            );
        }
      } catch (e) {
        // Handle login error
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      }
  }
}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formkey,
        child:
        Column(
          children: [   
            // Username
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: 'Enter your username',
                //border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),

            SizedBox(height: 20),
            // Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                //border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                return null;
              },
            ),
            // Password
            SizedBox(height: 20),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                //border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password is required';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            //Submit Button
            SizedBox(width: 150,
            child: StyledFilledButton(
              onPressed: _handleRegister,
              child: StyledButtonText('Register'),
            ),
            ),      
          ],
        )
      ),
    );
  }
}
