import 'package:flutter/cupertino.dart';
import 'package:talk_to_gpt/model/message.dart';

import '../db/historyRepo.dart';
import '../db/msgRrepo.dart';
import '../model/chat.dart';

class ChatProvider with ChangeNotifier{

  ChatProvider(){
    getChats();
  }

  final _msgRepository  = MsgRepository();
  final _historyRepository  = HistoryRepository();

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