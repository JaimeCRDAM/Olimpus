import '../models/Quest.dart';
import '../models/users/User.dart';
import '../models/users/humans/Human.dart';
import 'dart:io';

abstract class UserService {
  Future<User?> registerHuman(Human human);
  Future<bool> loginUser(User user);
  Future<bool?> updatePassword(User user, String password);
  Future<bool> updateAvatar(User user, File image);
  Future<bool> logOut(User user);
  Future<bool> createQuest(Quest quest);
  Future<List<Human>?> getAllHumans();
  Future<List<Human>?> getAllHumansHades();
  Future<List<Human>?> getAllHumansDead();
  Future<List<Quest>?> getAllQuests();
  Future<bool> assignQuest(Quest dropdownValueQuest, Human dropdownValueHuman, int dropdownValueQuestion, int amount);
  Future<bool> registerHumanByGod(Human human);
  Future<bool> massacreHumans(List<Human> humans);
  Future<bool> changeDestiny(int destiny);
}