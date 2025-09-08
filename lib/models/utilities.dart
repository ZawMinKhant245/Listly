import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showSuccessSnapBar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        content: Text(text),
      backgroundColor: Colors.green,
    )
  );

}
void showErrorSnapBar(BuildContext context,String text){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: Colors.red,
      )
  );

}