import 'package:flutter/material.dart';


class ClearDialog extends StatelessWidget {
  const ClearDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      content: Stack(
        children: [
          Positioned(
              right: 0,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: 40,
                    color: Theme.of(context).iconTheme.color,
                  ))),
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 30,),
              Text('Do you really want to clear Conversations ?', style: TextStyle(fontSize: 20),)
            ],
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: (){
          Navigator.pop(context, true);
        }, child: const Text('Yes')),
        TextButton(onPressed: (){
          Navigator.pop(context);
        }, child: const Text('No')),
      ],
    );
  }
}