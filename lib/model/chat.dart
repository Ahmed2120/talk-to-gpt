import 'package:flutter/material.dart';


class Chat with ChangeNotifier{
  int? id;
  String? name;
  // List<Product> products;

  Chat({this.id, this.name});

  Chat.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"];

  Map<String, Object?> toMap() {
    return {'id' : id, 'name': name,  };
  }
}