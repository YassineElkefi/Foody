import 'package:flutter/material.dart';
import 'package:foody/features/admin/screens/admin_screen.dart';
import 'package:foody/features/auth/providers/auth_provider.dart';
import 'package:foody/features/auth/screens/login/login_screen.dart';
import 'package:foody/features/auth/screens/register/register_screen.dart';
import 'package:foody/features/home/screens/home_screen.dart';
import 'package:foody/shared/widgets/styled_text.dart';
import 'package:foody/shared/widgets/styled_text_button.dart';
import 'package:foody/theme.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  bool _isSignUpForm = true;
  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      if (authProvider.isAuthenticated) {
        if (authProvider.isAdmin) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AdminScreen())
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen())
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context);

    /* WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (authProvider != null && authProvider.isAuthenticated) {
        if (authProvider.isAdmin) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AdminScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
        }
      }
    }); */

    return Scaffold(
      appBar: AppBar(
        title: StyledTitle('Foody'),
        centerTitle: true,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4.0),
            child: Container(
              color: AppColors.primaryColor,
              height: 1.0,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: StyledHeading('Welcome to Foody'),
              ),
            ),
            SizedBox(height: 20),
            Icon(Icons.fastfood, size: 100, color: AppColors.primaryColor),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Divider(
                    indent: 20.0,
                    endIndent: 10.0,
                    thickness: 1,
                  ),
                ),
                if (_isSignUpForm)
                Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                if (!_isSignUpForm)
                Text(
                  "Sign In",
                  style: TextStyle(color: Colors.blueGrey),
                ),
                Expanded(
                  child: Divider(
                    indent: 10.0,
                    endIndent: 20.0,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            if (_isSignUpForm)
              Column(
                children: [
                  const RegisterScreen(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 20.0,
                          endIndent: 10.0,
                          thickness: 1,
                        ),
                      ),
                      const Text("Already have an account?"),
                      Expanded(
                        child: Divider(
                          indent: 10.0,
                          endIndent: 20.0,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  StyledTextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUpForm = false;
                      });
                    },
                    text: 'Sign In',
                  ),
                ],
              ),
            if (!_isSignUpForm)
              Column(
                children: [
                  const LoginScreen(),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          indent: 20.0,
                          endIndent: 10.0,
                          thickness: 1,
                        ),
                      ),
                      const Text("Don't have an account?"),
                      Expanded(
                        child: Divider(
                          indent: 10.0,
                          endIndent: 20.0,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  StyledTextButton(
                    onPressed: () {
                      setState(() {
                        _isSignUpForm = true;
                      });
                    },
                    text: 'Sign Up',
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
