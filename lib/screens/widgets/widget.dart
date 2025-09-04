import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//TextFormField
class TextFromFieldWidget extends StatelessWidget {
  const TextFromFieldWidget({
    super.key,
    required this.icons,
    required this.text,
    this.iconButton,
    required this.textEditingController
  });

  final Icon icons;
  final String text;
  final IconButton? iconButton;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  blurStyle: BlurStyle.outer,
                  blurRadius:10,
                  offset: Offset(1, 1)

              )
            ]
        ),
        child: TextFormField(
          controller: textEditingController,
          validator: (value){
            if(value==null || value.isEmpty){
              return 'Enter $text';
            }else{
              return null;
            }
          },
          decoration: InputDecoration(
              prefixIcon: icons,
              suffixIcon: iconButton,
              border:InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

//button
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPress,
  });
  final String text;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(text,style: TextStyle(fontSize: 20),),
      style: ElevatedButton.styleFrom(
          minimumSize:Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white
      ),
    );
  }
}
