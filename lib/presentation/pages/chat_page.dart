import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_gpt/core/constants.dart';
import 'package:talk_to_gpt/model/message.dart';
import 'package:talk_to_gpt/presentation/widgets/msg_field.dart';

import '../../controller/chatProvider.dart';
import '../../core/global_methods.dart';
import 'package:http/http.dart' as http;

import '../../model/chat.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key, required this.chat});

  final Chat chat;

  final _msgController = TextEditingController();
  final ScrollController controller = ScrollController();

  List<Message> msges = [
    Message(txt: 'hello', isSender: 1),
    Message(
        txt:
            'hi hi hi hi hi hi hi hi hi hi hi hi hello hello hello hello hello hello hello hello hello'),
    Message(txt: 'hi', isSender: 1),
    Message(txt: 'hello', isSender: 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Back',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/icons/Vector.png',color: Theme.of(context).iconTheme.color),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          children: [
            Consumer<ChatProvider>(
                builder: (context, chatProvider, _) {
                return Expanded(
                    child: chatProvider.messages.isEmpty
                        ? Center(
                            child: Text(
                            'Ask anything, get your answer',
                            style: TextStyle(
                                color: Theme.of(context).dividerColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                          ))
                        : ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                            itemCount: chatProvider.messages.length,
                            itemBuilder: (context, index) => chatProvider.messages[index].isSender==1
                                ? senderContainer(context, chatProvider.messages[index])
                                : receiverContainer(context, chatProvider.messages[index]),
                          ));
              }
            ),
        Selector<ChatProvider, bool>(
            selector: (_, chatProvider) => chatProvider.msgLoading,
            builder: (context, msgLoading, _) {

              return msgLoading ? Container(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Icon(Icons.more_horiz, color: Theme.of(context).iconTheme.color,),
                ),
              ) : Container();
            }),
            Consumer<ChatProvider>(
                builder: (context, chatProvider, _) {
                return Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        // border: Border.all(color: Color(0xFFFFFFFF).withOpacity(0.32),),
                        color: Theme.of(context).canvasColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: MsgField(controller: _msgController, onSend: ()
                    async {
                      String msg = _msgController.text;
                      _msgController.clear();
                      FocusScope.of(context).unfocus();

                      controller.jumpTo(controller.position.maxScrollExtent);
                      await chatProvider.storeMsg(
                          message:
                              Message(txt: msg, chatId: chat.id, isSender: 1),
                          chat: chat);

                      controller.jumpTo(controller.position.maxScrollExtent);


                    },));
              }
            )
          ],
        ),
      ),
    );
  }

  Widget senderContainer(BuildContext context, Message singleChatMessage) {
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10))),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                child: Text(
                  singleChatMessage.txt!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textDirection: GlobalMethods.rtlLang(singleChatMessage.txt!)
                      ? TextDirection.rtl
                      : TextDirection.ltr,
                )),
          ],
        ),
      ),
    );
  }

  Widget receiverContainer(BuildContext context, Message singleChatMessage) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: Text(
                      singleChatMessage.txt!,
                      style: Theme.of(context).textTheme.bodyLarge,
                      textDirection:
                          GlobalMethods.rtlLang(singleChatMessage.txt!)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                    )),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Image.asset('assets/icons/like.png', color: Theme.of(context).dividerColor,),
            const SizedBox(
              width: 10,
            ),
            Image.asset('assets/icons/dislike.png', color: Theme.of(context).dividerColor,),
            const SizedBox(
              width: 30,
            ),
            Icon(
              Icons.copy,
              color: Theme.of(context).dividerColor,
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
                onTap: () {
                  final value = ClipboardData(text: singleChatMessage.txt!);
                  Clipboard.setData(value);
                },
                child: Text(
                  'Copy',
                  style: TextStyle(color: Theme.of(context).dividerColor),
                ))
          ],
        )
      ],
    );
  }

  send() async{
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
            'content': 'hello',
          }
        ],
      }),
    );
    print('--------------');
    print(res.body);
  }
}

