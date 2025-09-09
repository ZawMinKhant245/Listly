import 'package:flutter/cupertino.dart';
import 'package:listly/provider/user_provider.dart';
import 'package:provider/provider.dart';

class UserData{

  static UserProvider of(BuildContext context,{bool listen=true}){
    return Provider.of<UserProvider>(context,listen: false);
  }
}