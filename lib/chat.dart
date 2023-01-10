import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import 'Global.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String text = '';
  TextEditingController textEditingController = TextEditingController();
  List<Message> messages = [
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 1, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 3, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 4, minutes: 1)),
      isSentByMe: true,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: false,
    ),
    Message(
      text: 'Hello ! How are you',
      date: DateTime.now().subtract(const Duration(days: 5, minutes: 1)),
      isSentByMe: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        titleSpacing: 0,
        leading: IconButton(
          splashRadius: 25,
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_rounded, color: Global.blue,),
        ),
        title: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'profile', arguments: index),
              child: CircleAvatar(
                backgroundImage: AssetImage(Global.contactList[index]['image']),
              ),
            ),
            const SizedBox(width: 10),
            Text(Global.contactList[index]['name'],
              style: const TextStyle(
                fontFamily: 'Iphone',
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 1,
        shadowColor: const Color(0xFF78787F),
        actions: [
          IconButton(
            splashRadius: 25,
            icon: Icon(CupertinoIcons.video_camera, size: 30, color: Global.blue,),
            onPressed: (){},
          ),
          IconButton(
            splashRadius: 25,
            icon: Icon(CupertinoIcons.phone, color: Global.blue,),
            onPressed: () async {
              await FlutterPhoneDirectCaller.callNumber('+91 ${Global.contactList[index]['number']}');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GroupedListView<Message, DateTime>(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(8),
              reverse: true,
              order: GroupedListOrder.DESC,
              useStickyGroupSeparators: true,
              floatingHeader: true,
              elements: messages,
              groupBy: (message) => DateTime(
                message.date.year,
                message.date.month,
                message.date.day,
              ),
              groupHeaderBuilder: (Message message) => SizedBox(
                height: 40,
                child: Center(
                  child: Card(
                    color: Global.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        DateFormat.yMMMd().format(message.date),
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Iphone'
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              itemBuilder: (context, Message message) => Align(
                alignment: message.isSentByMe
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
                child: Card(
                  elevation: 8,
                  color: message.isSentByMe ? const Color(0xFF005046) : const Color(0xFF363638),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(message.text,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            // height: 60,
            color: const Color(0xFF171717),
            child: Row(
              children: [
                IconButton(
                  splashRadius: 20,
                  icon: Icon(CupertinoIcons.add, size: 30, color: Global.blue,),
                  onPressed: (){},
                ),
                IconButton(
                  splashRadius: 20,
                  icon: Icon(CupertinoIcons.camera, size: 28, color: Global.blue,),
                  onPressed: () async {
                    XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
                  },
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: CupertinoTextField(
                    controller: textEditingController,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Iphone',
                      fontSize: 20,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C2C2E),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: const Color(0xFF48484A)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    onChanged: (val){
                      setState(() {
                        text = val;
                      });
                    },
                  ),
                ),
                IconButton(
                  splashRadius: 20,
                  icon: Icon(CupertinoIcons.arrow_right_circle_fill, size: 35, color: Global.blue,),
                  onPressed: (){
                    setState(() {
                      if(text.isNotEmpty)
                        {
                          messages.add(Message(
                            text: text,
                            date: DateTime.now(),
                            isSentByMe: true,
                          ));
                        }
                    });
                    text = "";
                    textEditingController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
