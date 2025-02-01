import 'package:flutter/material.dart';
import 'package:foody/features/admin/screens/admin_screen.dart';
import 'package:foody/features/auth/providers/auth_provider.dart';
import 'package:foody/features/home/screens/home_screen.dart';
import 'package:foody/shared/widgets/styled_button_text.dart';
import 'package:foody/shared/widgets/styled_filled_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    if (_formkey.currentState!.validate()) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      

      final email = _emailController.text;
      final password = _passwordController.text;
      await authProvider.login(email, password);

      if (!mounted) return;

      if (authProvider.isAuthenticated) {
        if(authProvider.isAdmin){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminScreen()));
        }
        else if(!authProvider.isAdmin){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Invalid email or password'),
        ));
      }
    } else {
      print('Form is invalid');
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
              onPressed: _login,
              child: StyledButtonText('Login'),
            ),
            ),      
          ],
        )
      ),
    );
  }
}