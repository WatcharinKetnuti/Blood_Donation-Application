import 'package:flutter/material.dart';

class InputTextFieldWidget extends StatelessWidget {
  //final TextEditingController textEditingController;
  final String hintText, title;
  InputTextFieldWidget(this.title, this.hintText);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: TextField(
        //controller: textEditingController,
        decoration: InputDecoration(
          labelText: title,
          hintText: hintText,
          prefixIcon: const Icon(Icons.email_outlined),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
