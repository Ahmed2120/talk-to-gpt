import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:talk_to_gpt/controller/chatProvider.dart';
import 'package:talk_to_gpt/model/chat.dart';

import '../../controller/themeProvider.dart';
import '../../core/global_methods.dart';
import '../widgets/clear_dialog.dart';
import 'chat_page.dart';



class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final msgController = TextEditingController();

  late OpenAI openAI ;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   openAI = OpenAI.instance.build(
  //       token: AppConstants.gptKey,
  //       baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 9), sendTimeout: const Duration(seconds: 9)),enableLog: true);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Consumer<ChatProvider>(
                builder: (context, chatProvider, _) {
                return Container(
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                  ),
                  child: ListTile(
                    onTap: () async{
                      final chat = await chatProvider.storeChat(chat: Chat(name: ''));

                      if(!mounted) return;
                      GlobalMethods.navigate(context, ChatPage(chat: chat,));
                      },
                    title: Text('NewChat', style: Theme.of(context).textTheme.bodyMedium,),
                    trailing: Icon(Icons.arrow_forward_ios_sharp, color:Theme.of(context).iconTheme.color,),
                    leading: Icon(Icons.chat_bubble_outline, color: Theme.of(context).iconTheme.color,),
                  ),
                );
              }
            ),
            Consumer<ChatProvider>(
              builder: (context, chatProvider, _) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: chatProvider.chats.length,
                    itemBuilder: (context, index)=> Container(
                      decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                      ),
                      child: ListTile(
                        onTap: () {
                          chatProvider.getMessages(chatProvider.chats[index].id!);
                          GlobalMethods.navigate(context, ChatPage(chat: chatProvider.chats[index]));
                          },
                        title: Text(chatProvider.chats[index].name!, style: Theme.of(context).textTheme.bodyMedium,softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,),
                        trailing: Icon(Icons.arrow_forward_ios_sharp, color:Theme.of(context).iconTheme.color,),
                        leading: Icon(Icons.chat_bubble_outline, color: Theme.of(context).iconTheme.color,),
                      ),
                    ),
                  ),
                );
              }
            )
          ],
        ),
      ),
      bottomSheet: BottomSheet(
        enableDrag: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        shape: const RoundedRectangleBorder(),
        constraints: const BoxConstraints(
            minHeight: 300
        ),
        onClosing: (){},
        builder: (context)=> Container(
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Theme.of(context).dividerColor))
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Consumer<ChatProvider>(
                  builder: (context, chatProvider, _) {
                  return ListTile(
                    onTap: () {
                      showDialog(
                        context: context, barrierDismissible: false,
                        builder: (context)=> const ClearDialog()
                      ).then((value) { if(value != null && value) chatProvider.clearConversation();});
                      },
                    title: Text('Clear conversations', style: Theme.of(context).textTheme.bodyMedium,),
                    leading: Icon(Icons.delete_outline, color: Theme.of(context).iconTheme.color,),
                  );
                }
              ),
              ListTile(
                title: Text('Upgrade to Plus', style: Theme.of(context).textTheme.bodyMedium,),
                leading: Icon(Icons.person_2_outlined, color: Theme.of(context).iconTheme.color,),
                trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFFFBF3AD)
                  ),
                  child: const Text('NEW', style: TextStyle(color: Color(0xFF887B06)),),
                ),
              ),
              Consumer<ThemeProvider>(
                  builder: (context, themeProvider, _) {
                  return ListTile(
                    onTap: ()=>themeProvider.toggleTheme(),
                    title: Text('Light mode', style: Theme.of(context).textTheme.bodyMedium,),
                    leading: Icon(Icons.light_mode_outlined, color: Theme.of(context).iconTheme.color,),
                  );
                }
              ),
              ListTile(
                title: Text('Updates & FAQ', style: Theme.of(context).textTheme.bodyMedium,),
                leading: Icon(Icons.ios_share_outlined, color: Theme.of(context).iconTheme.color,),
              ),
              const ListTile(
                title: Text('Logout', style: TextStyle(color: Color(0xFFED8C8C)),),
                leading: Icon(Icons.logout, color: Color(0xFFED8C8C),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void send() async{
    String text = msgController.text;

    if(text.trim().isEmpty) return;

    print('---------------');
    print(openAI.token);

    final res = await openAI.onCompletion(request: CompleteText(prompt: text, model: TextBabbage001Model(), maxTokens: 100));
    print(res);

    if(res != null && res.choices.isNotEmpty){
      print('---------------');
      print(res);
    }

  }
}