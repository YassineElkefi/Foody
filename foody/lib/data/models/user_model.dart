import 'dart:convert';

class User{
  final String id;
  final String username;
  final String email;
  final String role;
  final String? token;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      role: json['role'],
      token: json['token']
    );
  }
  Map<String, dynamic> toJsonMap(){
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'token': token
    };
  }
  String toJson() => jsonEncode(toJsonMap());

  factory User.fromJsonString(String jsonString){
    return User.fromJson(jsonDecode(jsonString));
  }
}