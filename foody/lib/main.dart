import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:foody/core/config/graphql_config.dart';
import 'package:foody/core/services/auth_service.dart';
import 'package:foody/features/admin/screens/admin_screen.dart';
import 'package:foody/features/auth/providers/auth_provider.dart';
import 'package:foody/features/auth/screens/welcome/welcome_screen.dart';
import 'package:foody/features/home/screens/home_screen.dart';
import 'package:foody/theme.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env"); // Load environment variables first
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }

  final prefs = await SharedPreferences.getInstance();
  prefs.getString('user');
  final client = GraphqlConfig.initClient(null);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider(authService: AuthService(client: client.value))),
      ],
      child: MyApp(client: client,)
    ),
  );
}

class MyApp extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;
  const MyApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        return MaterialApp(
          title: 'Foody',
          theme: primaryTheme,
          home: auth.isAuthenticated ? (auth.isAdmin ? AdminScreen() : HomeScreen()) : WelcomeScreen(),
        );
      }
    );
  }
}