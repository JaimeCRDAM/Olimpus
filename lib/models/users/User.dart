class User {
  late String? email;
  late String jwt;
  late String type;


  Map<String, dynamic>? toJsonAuth(){}
  Map<String, dynamic>? toJsonLogin(){}
}