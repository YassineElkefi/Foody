import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlConfig {
  static HttpLink httpLink = HttpLink(dotenv.env['GRAPHQL_ENDPOINT']!);

  static ValueNotifier<GraphQLClient> initClient(String? token) {
    return ValueNotifier(
      GraphQLClient(
        link: AuthLink(getToken: () async => token != null ? 'Bearer $token' : null).concat(httpLink),
        cache: GraphQLCache(),
      )
    );
}
}