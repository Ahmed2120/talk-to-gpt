import 'package:flutter/material.dart';


class Message with ChangeNotifier{
  int? id;
  int? chatId;
  String? txt;
  int isSender;
  // List<Product> products;

  Message({this.id, this.chatId, this.txt, this.isSender = 0});

  Message.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        chatId = res["chatId"],
        txt = res["txt"],
        isSender = res["isSender"];

  Map<String, Object?> toMap() {
    return {'id' : id, 'chatId': chatId, 'txt': txt, 'isSender': isSender, };
  }
}