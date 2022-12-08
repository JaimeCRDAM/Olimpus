import 'package:http/http.dart' as http;
import '../models/Human.dart';

import 'UserService.dart';

class MyApiClient implements UserService {
  var server = 'https://example.com/';
  @override
  Future<void> registerUser(Human human) async {
    var response = await http.post(
      Uri.parse('${server}api/users'),
      body: human.toJson()
    );
  }
}