import 'package:crud_flutter/DB/repository.dart';
import 'package:crud_flutter/models/User.dart';

class UserService{
 late Repository _repository;
 UserService(){
   _repository=Repository();
 }
//  save user
SaveUser(User user)async{
   return await _repository.InsertData("Users",user.userMap());

}
//    read all user
readAllUsers() async{
   return await _repository.readData('Users');
}
  // EditUser
  UpdateUser(User user) async{
   return await _repository.updateData('users', user.userMap());
  }

  deleteUser(id) async{
   return await _repository.deleteUser('users', id);
  }
}