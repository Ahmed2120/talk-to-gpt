import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:talk_to_gpt/model/message.dart';

import '../core/constants.dart';
import '../db/historyRepo.dart';
import '../db/msgRrepo.dart';
import '../model/chat.dart';
import 'package:http/http.dart' as http ;

class ChatProvider with ChangeNotifier{

  ChatProvider(){
    getChats();
  }

  final _msgRepository  = MsgRepository();
  final _historyRepository  = HistoryRepository();

  bool msgLoading = false;

  List<Chat> _chats = [];
  List<Chat> get chats { return _chats;}

  List<Message> _messages = [];
  List<Message> get messages { return _messages;}

  storeMsg({required Message message, required Chat chat}) async{
    if(message.txt!.trim().isEmpty) return;

    message.id = await _msgRepository.insert(message);

    if(message.isSender == 1){
      chat.name = message.txt;
      _historyRepository.update(chat);
    }
    messages.add(message);

    notifyListeners();

    try{
      msgLoading = true;
      notifyListeners();

      final assistMsg = await getAssistantMsg(message.txt!);
      Message m = Message(txt: assistMsg, chatId: chat.id);
      m.id = await _msgRepository.insert(m);
      messages.add(m);

      msgLoading = false;
      notifyListeners();
    }catch(e){

      msgLoading = false;
      notifyListeners();
    }
  }

  getAssistantMsg(String msg) async{
    // msgLoading = true;
    // notifyListeners();

    // try{
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${AppConstants.gptKey}',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content': msg,
            }
          ],
        }),
      );
      print(res.body);
      final jsonRes = jsonDecode(res.body);

      final assistMsg = jsonRes['choices'][0]['message']['content'];
      print('---------------------');
      print(assistMsg);
      return assistMsg;

      // msgLoading = false;
      // notifyListeners();

    // }catch(e){
    //   print(e);
    //   msgLoading = false;
    //   notifyListeners();
    // }


  }

  Future<Chat> storeChat({required Chat chat}) async{
    chat.id = await _historyRepository.insert(chat);
    _chats.add(chat);

    _messages = [];

    notifyListeners();

    return chat;
  }

  getMessages(int chatId)async{
    _messages = await _msgRepository.retrieveByChatId(chatId);
  }

  getChats()async{
    _chats = await _historyRepository.retrieve();
    notifyListeners();
  }

  clearConversation()async{
    await _historyRepository.deleteTable();
    await _msgRepository.deleteTable();

    _messages.clear();
    chats.clear();

    notifyListeners();
  }
}