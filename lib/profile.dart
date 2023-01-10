import 'package:flutter/material.dart';

import 'Global.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_rounded, color: Global.blue,),
                Text(" Back",
                  style: TextStyle(
                    color: Global.blue,
                    fontSize: 20,
                    fontFamily: 'Iphone',
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text("Contact Info",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Iphone',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Hero(
        tag: Global.contactList[index]['image'],
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Global.contactList[index]['image'],),
              scale: 0.1,
            ),
          ),
        ),
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
