import '../models/users/User.dart';
import '../models/users/humans/Human.dart';

abstract class UserService {
  Future<User?> registerHuman(Human human);
  Future<User?> loginUser(User user);
  Future<bool?> updatePassword(User user);
}