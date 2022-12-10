import '../models/users/User.dart';
import '../models/users/humans/Human.dart';
import 'dart:io';

abstract class UserService {
  Future<User?> registerHuman(Human human);
  Future<User?> loginUser(User user);
  Future<bool?> updatePassword(User user, String password);
  Future<bool> updateAvatar(User user, File image);
  Future<bool> logOut(User user);
}