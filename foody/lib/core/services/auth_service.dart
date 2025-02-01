import 'package:foody/data/models/user_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthService {
  final GraphQLClient client;

  AuthService({required this.client});

  Future<User?> login(String email, String password) async {
    
    const String loginMutation = """

        mutation Login(\$email: String!, \$password: String!) {
          login(email: \$email, password: \$password) {
            id
            username
            email
            role
            token
          }
        }
    """;

    final result = await client.mutate(
      MutationOptions(document: gql(loginMutation), variables: {
        'email': email,
        'password': password,
      }),
    );

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }
    
    return User.fromJson(result.data!['login']);
  }

  Future<User?> register(String username, String email, String password) async {
    
    const String registerMutation = """

        mutation Register(\$username: String!, \$email: String!, \$password: String!) {
          register(username: \$username, email: \$email, password: \$password) {
            id
            username
            email
            role
            token
          }
        }
    """;

    final result = await client.mutate(
      MutationOptions(document: gql(registerMutation), variables: {
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }
    
    return User.fromJson(result.data!['register']);
  }
}