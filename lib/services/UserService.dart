import '../models/users/User.dart';
import '../models/users/humans/Human.dart';

abstract class UserService {
  Future<void> registerHuman(Human human);
  Future<User?> loginUser(User user);
}