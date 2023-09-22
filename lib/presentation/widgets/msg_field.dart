import 'package:flutter/material.dart';

class MsgField extends StatelessWidget {
  MsgField(
      {
        required TextEditingController controller,
        this.txt,
required this.onSend
      })
      : _controller = controller;

  final TextEditingController _controller;
  String ? txt;
  Function onSend;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            // filled: true,
            // fillColor: Color(0xFFFFFFFF).withOpacity(0.1),
            suffixIcon: IconButton(onPressed: ()=>onSend(), icon:  Image.asset('assets/icons/Frame 12.png')),

            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFFFFFFF).withOpacity(0.8),
                ),
                borderRadius: BorderRadius.circular(10)),
            enabledBorder: InputBorder.none
          ),

      ),
    );
  }
}
