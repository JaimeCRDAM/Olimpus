import '../models/Human.dart';

abstract class UserService {
  Future<void> registerUser(Human human);
}