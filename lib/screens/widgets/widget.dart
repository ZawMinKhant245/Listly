import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFromFieldWidget extends StatelessWidget {
  const TextFromFieldWidget({
    super.key,
    required this.icons,
    required this.text,
    this.iconButton,
  });

  final Icon icons;
  final String text;
  final IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
          decoration: InputDecoration(
              prefixIcon: icons,
              suffixIcon: iconButton,
              border:InputBorder.none,
              hintText: text,
              hintStyle: TextStyle(fontSize: 23),
          ),
        ),
      ),
    );
  }
}