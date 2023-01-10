import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import 'Global.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  getImage() async {
    XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pic != null)
    {
      setState(() {
        Global.image = File(pic.path);
      });
    }
  }
  camera() async {
    XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
    if(pic != null)
    {
      setState(() {
        Global.cameraImage = File(pic.path);
      });
    }
  }
  Widget line(){
    return Container(
      height: 1,
      color: const Color(0xff2D2D30),
    );
  }
  Widget profileOption({required Color color, required Icon icon, required String text}){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Row(
        children: [
          Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: icon,
          ),
          const SizedBox(width: 15,),
          Text(text,
            style: const TextStyle(
              fontFamily: 'Iphone',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          const Spacer(),
          const Icon(CupertinoIcons.forward, color: Color(0xff5A5A5F)),
        ],
      ),
    );
  }
  Widget drawerOption({required Icon icon, required String text}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 20),
          Text(text,
            style: const TextStyle(
              fontFamily: 'Iphone',
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
  bool platForm = false, filter = false;
  DateTime currentTime = DateTime.now();
  int pageIndex = 0, currentStep = 0;
  String name = "", mobile = "";
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mobileEditingController = TextEditingController();
  GlobalKey<FormState> nameKey = GlobalKey<FormState>();
  GlobalKey<FormState> mobileKey = GlobalKey<FormState>();
  final searchCall = ValueNotifier<String>('');
  final searchContact = ValueNotifier<String>('');
  final searchStatus = ValueNotifier<String>('');
  late TabController tabController;
  File? addImage;
  PageController pageController = PageController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: () async {
          final iWillPop = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context){
                return AlertDialog(
                  title: const Text("Are You Sure to Exit ?"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  actions: [
                    ElevatedButton(
                      child: const Text("Yes"),
                      onPressed: (){Navigator.pop(context,true);},
                    ),
                    TextButton(
                      child: const Text("No"),
                      onPressed: (){Navigator.pop(context,false);},
                    ),
                  ],
                );
              }
          );
          return iWillPop;
        },
        child: Scaffold(
          drawer: SafeArea(
            child: Drawer(
              backgroundColor: const Color(0xff2A2A2C),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      // color: Colors.white70,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (Global.image != null) ? CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(Global.image!),
                          ) : const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage('build/image/profile2.png'),
                          ),
                          const SizedBox(height: 15),
                          const Text("Umang Kaklotar",
                            style: TextStyle(
                              fontFamily: 'Iphone',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 3),
                          const Text("umangkaklotar2004@gmail.com",
                            style: TextStyle(
                              fontFamily: 'Iphone',
                              color: Color(0xff9D9DA4),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 2,
                    color: Colors.white,
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      color: const Color(0xff2A2A2C),
                      child: Column(
                        children: [
                          drawerOption(icon: const Icon(Icons.group_rounded, size: 25, color: Colors.white), text: 'New Group'),
                          drawerOption(icon: const Icon(CupertinoIcons.person, size: 25, color: Colors.white), text: 'New Contact'),
                          drawerOption(icon: const Icon(CupertinoIcons.phone, size: 25, color: Colors.white), text: 'Calls'),
                          drawerOption(icon: const Icon(CupertinoIcons.bookmark, size: 25, color: Colors.white), text: 'Saved Message'),
                          drawerOption(icon: const Icon(CupertinoIcons.settings, size: 25, color: Colors.white), text: 'Settings'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar: AppBar(
            leadingWidth: 70,
            leading: Builder(
              builder: (context) => IconButton(
                splashRadius: 25,
                icon: (Global.image != null) ? CircleAvatar(
                  backgroundImage: FileImage(Global.image!),
                ) : const CircleAvatar(
                  backgroundImage: AssetImage('build/image/profile2.png'),
                ),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: const Text("Whatsapp",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: 'Iphone',
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: IconButton(
                  splashRadius: 25,
                  icon: (!platForm) ? const Icon(Icons.apple) : const Icon(Icons.android_rounded),
                  onPressed: (){
                    setState(() {
                      platForm = !platForm;
                    });
                  },
                ),
              ),
            ],
            bottom: (platForm == false) ? TabBar(
              isScrollable: true,
              controller: tabController,
              onTap: (val){
                setState(() {
                  pageController.animateToPage(val, duration: const Duration(milliseconds: 300), curve: Curves.ease);
                  pageIndex = val;
                  (pageIndex == 2) ? camera() : null;
                });
              },
              physics: const BouncingScrollPhysics(),
              indicatorColor: Global.blue,
              labelStyle: const TextStyle(
                fontFamily: 'Iphone',
                fontSize: 15,
              ),
              tabs: const <Tab>[
                Tab(
                  text: "Status",
                ),
                Tab(
                  text: "Calls",
                ),
                Tab(
                  text: "Camera",
                ),
                Tab(
                  text: "Chats",
                ),
                Tab(
                  text: "Settings",
                ),
              ],
            ) : PreferredSize(preferredSize: const Size(0,0), child: Container()),
          ),
          body: SafeArea(
            child: PageView(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              onPageChanged: (val){
                setState(() {
                  tabController.animateTo(val);
                  pageIndex = val;
                  (pageIndex == 2) ? camera() : null;
                });
              },
              children: [

                //       status
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Status",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xff2A2A2C),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(CupertinoIcons.search,
                                color: Color(0xffA2A2A9),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Iphone",
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xffA2A2A9),
                                    fontSize: 20,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 6),
                                ),
                                onChanged: (val){
                                  setState(() {
                                    searchStatus.value = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      line(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 80,
                        width: _width,
                        alignment: Alignment.center,
                        color: const Color(0xff1C1C1E),
                        child: Row(
                          children: [
                            Stack(
                              alignment: const Alignment(10,1),
                              children: [
                                (Global.image != null) ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: FileImage(Global.image!),
                                ) : const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('build/image/profile2.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: FloatingActionButton(
                                    onPressed: () async {
                                      XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
                                    },
                                    child: const Icon(Icons.add, size: 15,),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("My Status",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Text("Add to my status",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xff9D9DA4),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
                              },
                              child: CircleAvatar(
                                backgroundColor: const Color(0xff2C2C2D),
                                child: Icon(Icons.camera_alt_rounded, color: Global.blue,),
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              backgroundColor: const Color(0xff2C2C2D),
                              child: Icon(CupertinoIcons.pencil, color: Global.blue,),
                            ),
                          ],
                        ),
                      ),
                      line(),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 5),
                        child: Text("RECENT UPDATES",
                          style: TextStyle(
                            color: Color(0xff9D9DA4),
                            fontFamily: 'Iphone',
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      line(),
                      ...Global.contactList.map((e) {
                        if(e['name'].toString().toUpperCase().contains(searchStatus.value.toUpperCase()) && e['seen'] == false) {
                          return Ink(
                          // color: const Color(0xFF1C1C1E),
                          child: InkWell(
                            splashColor: const Color(0xff3A3A3C),
                            splashFactory: InkRipple.splashFactory,
                            onTap: () => Navigator.pushNamed(context, 'story', arguments: Global.contactList.indexOf(e)),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  height: 80,
                                  width: _width,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: e['seen'] == false ? Global.blue : Colors.grey,
                                              width: 2,
                                            )
                                        ),
                                        child: CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(e['image']),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(e['name'],
                                            style: const TextStyle(
                                              fontFamily: 'Iphone',
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 5),
                                          Text(e['storyTime'],
                                            style: const TextStyle(
                                              fontFamily: 'Iphone',
                                              color: Color(0xff9D9DA4),
                                              fontSize: 15,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: Global.contactList.length - 1 == Global.contactList.indexOf(e) ? 0 : 85),
                                  child: line(),
                                ),
                              ],
                            ),
                          ),
                        );
                        }
                        return Container();
                      }).toList(),
                      if(Global.status == true) const Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 5, top: 30),
                        child: Text("VIEWED UPDATES",
                          style: TextStyle(
                            color: Color(0xff9D9DA4),
                            fontFamily: 'Iphone',
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                      if(Global.status == true) line(),
                      ...Global.contactList.map((e) {
                        if(e['name'].toString().toUpperCase().contains(searchStatus.value.toUpperCase()) && e['seen'] == true) {
                          return Ink(
                            // color: const Color(0xFF1C1C1E),
                            child: InkWell(
                              splashColor: const Color(0xff3A3A3C),
                              splashFactory: InkRipple.splashFactory,
                              onTap: () => Navigator.pushNamed(context, 'story', arguments: Global.contactList.indexOf(e)),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                    height: 80,
                                    width: _width,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: e['seen'] == false ? Global.blue : Colors.grey,
                                                width: 2,
                                              )
                                          ),
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(e['image']),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(e['name'],
                                              style: const TextStyle(
                                                fontFamily: 'Iphone',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 5),
                                            Text(e['storyTime'],
                                              style: const TextStyle(
                                                fontFamily: 'Iphone',
                                                color: Color(0xff9D9DA4),
                                                fontSize: 15,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: Global.contactList.length - 1 == Global.contactList.indexOf(e) ? 0 : 85),
                                    child: line(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return Container();
                      }).toList(),
                    ],
                  ),
                ),

                //       calls
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Calls",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          color: const Color(0xff2A2A2C),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Icon(CupertinoIcons.search,
                                color: Color(0xffA2A2A9),
                              ),
                            ),
                            Expanded(
                              child: TextFormField(
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: "Iphone",
                                  fontWeight: FontWeight.w600,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xffA2A2A9),
                                    fontSize: 20,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 6),
                                ),
                                onChanged: (val){
                                  setState(() {
                                    searchCall.value = val;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      line(),
                      ...Global.contactList.map((e) {
                        if(e['name'].toString().toUpperCase().contains(searchCall.value.toUpperCase())) {
                          return Column(
                            children: [
                              Slidable(
                                key: UniqueKey(),
                                startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.2,
                                  dragDismissible: true,
                                  closeThreshold: 0.5,
                                  dismissible: DismissiblePane(onDismissed: () async {
                                    await FlutterPhoneDirectCaller.callNumber('+91 ${e['number']}');
                                    setState(() {});
                                  }),
                                  children: [
                                    SlidableAction(
                                      onPressed: (val) async {
                                        await FlutterPhoneDirectCaller.callNumber('+91 ${e['number']}');
                                      },
                                      backgroundColor: const Color(0xFF30D158),
                                      foregroundColor: Colors.white,
                                      icon: CupertinoIcons.phone,
                                      label: "Call",
                                      spacing: 5,
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  extentRatio: 0.2,
                                  dragDismissible: true,
                                  closeThreshold: 0.5,
                                  dismissible: DismissiblePane(onDismissed: () {
                                    setState(() {
                                      Global.contactList.remove(e);
                                    });
                                  }),
                                  children: [
                                    SlidableAction(
                                      onPressed: (val){
                                        setState(() {
                                          Global.contactList.remove(e);
                                        });
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: CupertinoIcons.delete,
                                      label: "Delete",
                                      spacing: 5,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  splashColor: const Color(0xff3A3A3C),
                                  splashFactory: InkRipple.splashFactory,
                                  onTap: () async {
                                    await FlutterPhoneDirectCaller.callNumber('+91 ${e['number']}');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    height: 80,
                                    width: _width,
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: AssetImage(e['image']),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(e['name'],
                                              style: const TextStyle(
                                                fontFamily: 'Iphone',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 0.5,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 6),
                                            const Text("📞 Incoming",
                                              style: TextStyle(
                                                fontFamily: 'Iphone',
                                                color: Color(0xff9D9DA4),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Text(e['time'],
                                          style: const TextStyle(
                                            color: Color(0xff9D9DA4),
                                            fontFamily: 'Iphone',
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () => Navigator.pushNamed(context, 'chat', arguments: Global.contactList.indexOf(e)),
                                          child: Icon(CupertinoIcons.info, size: 25, color: Global.blue,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: Global.contactList.length - 1 == Global.contactList.indexOf(e) ? 0 : 85),
                                child: line(),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }).toList(),
                    ],
                  ),
                ),

                //       camera
                (Global.cameraImage != null)
                    ? Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(Global.cameraImage!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
                    : Container(),

                //       chats
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Chats",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xff2A2A2C),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Icon(CupertinoIcons.search,
                                        color: Color(0xffA2A2A9),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "Iphone",
                                          fontWeight: FontWeight.w600,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                            fontFamily: 'Iphone',
                                            color: Color(0xffA2A2A9),
                                            fontSize: 20,
                                          ),
                                          contentPadding: EdgeInsets.symmetric(horizontal: 6),
                                        ),
                                        onChanged: (val){
                                          setState(() {
                                            searchContact.value = val;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    filter = !filter;
                                  });
                                },
                                child: Icon(
                                  (filter) ? CupertinoIcons.line_horizontal_3_decrease_circle_fill
                                      : CupertinoIcons.line_horizontal_3_decrease_circle,
                                  size: 30,
                                  color: Global.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Broadcast Lists",
                              style: TextStyle(
                                color: Global.blue,
                                fontFamily: 'Iphone',
                                fontSize: 20,
                              ),
                            ),
                            Text("New Group",
                              style: TextStyle(
                                color: Global.blue,
                                fontFamily: 'Iphone',
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      line(),
                      if(!filter)
                        Column(
                          children: [
                            InkWell(
                              splashColor: const Color(0xff3A3A3C),
                              splashFactory: InkRipple.splashFactory,
                              onTap: (){
                                Navigator.pushNamed(context, 'archive');
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10, ),
                                child: Row(
                                  children: const [
                                    Icon(CupertinoIcons.archivebox_fill, color: Colors.grey,),
                                    Padding(
                                      padding: EdgeInsets.only(left: 32),
                                      child: Text("Archived",
                                        style: TextStyle(
                                          fontFamily: 'Iphone',
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 85),
                              child: line(),
                            ),
                            ...Global.contactList.map((e) {
                              if(e['name'].toString().toUpperCase().contains(searchContact.value.toUpperCase())) {
                                if(!e['archive'] && e['pin']) {
                                  return Column(
                                    children: [
                                      Slidable(
                                        key: UniqueKey(),
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.4,
                                          dragDismissible: true,
                                          closeThreshold: 0.5,
                                          dismissible: DismissiblePane(onDismissed: () {
                                            setState(() {
                                              e['archive'] = !e['archive'];
                                            });
                                          }),
                                          children: [
                                            SlidableAction(
                                              onPressed: (val){
                                                setState(() {
                                                  e['archive'] = !e['archive'];
                                                });
                                              },
                                              backgroundColor: const Color(0xff4A6FA3),
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.archivebox_fill,
                                              label: "Archive",
                                              spacing: 5,
                                            ),
                                            SlidableAction(
                                              onPressed: (val){
                                                setState(() {
                                                  e['pin'] = !e['pin'];
                                                });
                                              },
                                              backgroundColor: const Color(0xff646468),
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.pin_slash_fill,
                                              label: "Unpin",
                                              spacing: 2,
                                            ),
                                          ],
                                        ),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.4,
                                          dragDismissible: true,
                                          closeThreshold: 0.5,
                                          dismissible: DismissiblePane(onDismissed: () {
                                            setState(() {
                                              Global.contactList.remove(e);
                                            });
                                          }),
                                          children: [
                                            SlidableAction(
                                              onPressed: (val){
                                              },
                                              backgroundColor: Global.blue,
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.chat_bubble_fill,
                                              label: "Unread",
                                              spacing: 2,
                                            ),
                                            SlidableAction(
                                              onPressed: (val){
                                                setState(() {
                                                  Global.contactList.remove(e);
                                                });
                                              },
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.delete,
                                              label: "Delete",
                                              spacing: 5,
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          splashColor: const Color(0xff3A3A3C),
                                          splashFactory: InkRipple.splashFactory,
                                          onTap: (){
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                                              ),
                                              backgroundColor: const Color(0xFF2A2A2C),
                                              context: context,
                                              builder: (context){
                                                return DraggableScrollableSheet(
                                                  initialChildSize: 0.5,
                                                  expand: false,
                                                  builder: (context, _) {
                                                    return Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 60,
                                                            backgroundImage: AssetImage(e['image']),
                                                          ),
                                                          const SizedBox(height: 15,),
                                                          Text(e['name'],
                                                            style: const TextStyle(
                                                              fontFamily: 'Iphone',
                                                              color: Colors.white,
                                                              fontSize: 24,
                                                              fontWeight: FontWeight.bold,
                                                              letterSpacing: 0.5,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          const SizedBox(height: 5),
                                                          Text(e['number'],
                                                            style: const TextStyle(
                                                              fontFamily: 'Iphone',
                                                              color: Color(0xff9D9DA4),
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 40,),
                                                          CupertinoButton.filled(
                                                            child: const Text("Send Meaasage"),
                                                            onPressed: () => Navigator.pushNamed(context, 'chat', arguments: Global.contactList.indexOf(e)),
                                                          ),
                                                          const SizedBox(height: 20,),
                                                          CupertinoButton.filled(
                                                            child: const Text("Share"),
                                                            onPressed: () => Share.share('${e['name']} || ${e['number']}', subject: 'mm'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                            height: 80,
                                            width: _width,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => Navigator.pushNamed(context, 'profile', arguments: Global.contactList.indexOf(e)),
                                                  child: Hero(
                                                    tag: e['image'],
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: AssetImage(e['image']),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(e['name'],
                                                      style: const TextStyle(
                                                        fontFamily: 'Iphone',
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.5,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(e['mes'],
                                                      style: const TextStyle(
                                                        fontFamily: 'Iphone',
                                                        color: Color(0xff9D9DA4),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(e['time'],
                                                      style: const TextStyle(
                                                        color: Color(0xff9D9DA4),
                                                        fontFamily: 'Iphone',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        if(e['pin']) const Icon(CupertinoIcons.pin_fill, size: 20, color: Color(0xff9D9DA4),),
                                                        const SizedBox(width: 10),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor: Global.blue,
                                                          child: Text(e['no'],
                                                            style: const TextStyle(
                                                              fontFamily: 'Iphone',
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 85),
                                        child: line(),
                                      ),
                                    ],
                                  );
                                }
                              }
                              return Container();
                            }).toList(),
                            ...Global.contactList.map((e) {
                              if(e['name'].toString().toUpperCase().contains(searchContact.value.toUpperCase())) {
                                if(!e['archive'] && !e['pin']) {
                                  return Column(
                                    children: [
                                      Slidable(
                                        key: UniqueKey(),
                                        startActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.4,
                                          dragDismissible: true,
                                          closeThreshold: 0.5,
                                          dismissible: DismissiblePane(onDismissed: () {
                                            setState(() {
                                              e['archive'] = !e['archive'];
                                            });
                                          }),
                                          children: [
                                            SlidableAction(
                                              onPressed: (val){
                                                setState(() {
                                                  e['archive'] = !e['archive'];
                                                });
                                              },
                                              backgroundColor: const Color(0xff4A6FA3),
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.archivebox_fill,
                                              label: "Archive",
                                              spacing: 5,
                                            ),
                                            SlidableAction(
                                              onPressed: (val){
                                                setState(() {
                                                  e['pin'] = !e['pin'];
                                                });
                                              },
                                              backgroundColor: const Color(0xff646468),
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.pin_fill,
                                              label: "Pin",
                                              spacing: 2,
                                            ),
                                          ],
                                        ),
                                        endActionPane: ActionPane(
                                          motion: const ScrollMotion(),
                                          extentRatio: 0.4,
                                          dragDismissible: true,
                                          closeThreshold: 0.5,
                                          dismissible: DismissiblePane(onDismissed: () {
                                            setState(() {
                                              Global.contactList.remove(e);
                                            });
                                          }),
                                          children: [
                                            SlidableAction(
                                              onPressed: (val){
                                              },
                                              backgroundColor: Global.blue,
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.chat_bubble_fill,
                                              label: "Unread",
                                              spacing: 2,
                                            ),
                                            SlidableAction(
                                              onPressed: (val){
                                                setState(() {
                                                  Global.contactList.remove(e);
                                                });
                                              },
                                              backgroundColor: Colors.red,
                                              foregroundColor: Colors.white,
                                              icon: CupertinoIcons.delete,
                                              label: "Delete",
                                              spacing: 5,
                                            ),
                                          ],
                                        ),
                                        child: InkWell(
                                          splashColor: const Color(0xff3A3A3C),
                                          splashFactory: InkRipple.splashFactory,
                                          onTap: (){
                                            showModalBottomSheet(
                                              isScrollControlled: true,
                                              shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                                              ),
                                              backgroundColor: const Color(0xFF2A2A2C),
                                              context: context,
                                              builder: (context){
                                                return DraggableScrollableSheet(
                                                  initialChildSize: 0.5,
                                                  expand: false,
                                                  builder: (context, _) {
                                                    return Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 60,
                                                            backgroundImage: AssetImage(e['image']),
                                                          ),
                                                          const SizedBox(height: 15,),
                                                          Text(e['name'],
                                                            style: const TextStyle(
                                                              fontFamily: 'Iphone',
                                                              color: Colors.white,
                                                              fontSize: 24,
                                                              fontWeight: FontWeight.bold,
                                                              letterSpacing: 0.5,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          const SizedBox(height: 5),
                                                          Text(e['number'],
                                                            style: const TextStyle(
                                                              fontFamily: 'Iphone',
                                                              color: Color(0xff9D9DA4),
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 40,),
                                                          CupertinoButton.filled(
                                                            child: const Text("Send Meaasage"),
                                                            onPressed: () => Navigator.pushNamed(context, 'chat', arguments: Global.contactList.indexOf(e)),
                                                          ),
                                                          const SizedBox(height: 20,),
                                                          CupertinoButton.filled(
                                                            child: const Text("Share"),
                                                            onPressed: () => Share.share('${e['name']} || ${e['number']}', subject: 'mm'),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                            height: 80,
                                            width: _width,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => Navigator.pushNamed(context, 'profile', arguments: Global.contactList.indexOf(e)),
                                                  child: Hero(
                                                    tag: e['image'],
                                                    child: CircleAvatar(
                                                      radius: 30,
                                                      backgroundImage: AssetImage(e['image']),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(e['name'],
                                                      style: const TextStyle(
                                                        fontFamily: 'Iphone',
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.5,
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(e['mes'],
                                                      style: const TextStyle(
                                                        fontFamily: 'Iphone',
                                                        color: Color(0xff9D9DA4),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [
                                                    Text(e['time'],
                                                      style: const TextStyle(
                                                        color: Color(0xff9D9DA4),
                                                        fontFamily: 'Iphone',
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Row(
                                                      children: [
                                                        if(e['pin']) const Icon(CupertinoIcons.pin_fill, size: 20, color: Color(0xff9D9DA4),),
                                                        const SizedBox(width: 10),
                                                        CircleAvatar(
                                                          radius: 10,
                                                          backgroundColor: Global.blue,
                                                          child: Text(e['no'],
                                                            style: const TextStyle(
                                                              fontFamily: 'Iphone',
                                                              fontSize: 14,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: Global.contactList.length - 1 == Global.contactList.indexOf(e) ? 0 : 85),
                                        child: line(),
                                      ),
                                    ],
                                  );
                                }
                              }
                              return Container();
                            }).toList(),
                          ],
                        ),
                      if(filter)
                        Container(
                          height: _height / 1.7,
                          alignment: Alignment.center,
                          child: Text("Filter",
                            style: TextStyle(
                              color: Global.blue,
                              fontFamily: 'Iphone',
                              fontSize: 20,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                //       settings
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text("Settings",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      line(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        height: 80,
                        width: _width,
                        alignment: Alignment.center,
                        color: const Color(0xff1C1C1E),
                        child: Row(
                          children: [
                            Stack(
                              alignment: const Alignment(10,1),
                              children: [
                                (Global.image != null) ? CircleAvatar(
                                  radius: 30,
                                  backgroundImage: FileImage(Global.image!),
                                ) : const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage('build/image/profile2.png'),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: FloatingActionButton(
                                    onPressed: (){
                                      getImage();
                                    },
                                    child: const Icon(Icons.add, size: 15,),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text("Umang Kaklotar",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text("Be Happy 😇",
                                  style: TextStyle(
                                    fontFamily: 'Iphone',
                                    color: Color(0xff9D9DA4),
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CircleAvatar(
                              backgroundColor: const Color(0xff2C2C2D),
                              child: Icon(CupertinoIcons.qrcode, color: Global.blue,),
                            ),
                          ],
                        ),
                      ),
                      line(),
                      const SizedBox(height: 40),
                      line(),
                      Container(
                        color: const Color(0xff1C1C1E),
                        child: Column(
                          children: [
                            profileOption(
                              color: const Color(0xffFDC501),
                              icon: const Icon(CupertinoIcons.star_fill, color: Colors.white,),
                              text: 'Starred Messages',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xff09AC9F),
                              icon: const Icon(CupertinoIcons.device_laptop, color: Colors.white,),
                              text: 'Linked Devices',
                            ),
                          ],
                        ),
                      ),
                      line(),
                      const SizedBox(height: 40),
                      line(),
                      Container(
                        color: const Color(0xff1C1C1E),
                        child: Column(
                          children: [
                            profileOption(
                              color: const Color(0xff007BFD),
                              icon: const Icon(Icons.key_rounded, color: Colors.white,),
                              text: 'Account',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xff35A8DB),
                              icon: const Icon(CupertinoIcons.lock_fill, color: Colors.white,),
                              text: 'Privacy',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xff4BD663),
                              icon: const Icon(Icons.whatsapp_rounded, color: Colors.white,),
                              text: 'Chats',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xffFD3D30),
                              icon: const Icon(CupertinoIcons.app_badge, color: Colors.white,),
                              text: 'Notifications',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xff27BDA4),
                              icon: const Icon(CupertinoIcons.money_dollar_circle, color: Colors.white,),
                              text: 'Payments',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xff35C659),
                              icon: const Icon(CupertinoIcons.arrow_up_arrow_down, color: Colors.white,),
                              text: 'Storage and Data',
                            ),
                          ],
                        ),
                      ),
                      line(),
                      const SizedBox(height: 40),
                      line(),
                      Container(
                        color: const Color(0xff1C1C1E),
                        child: Column(
                          children: [
                            profileOption(
                              color: const Color(0xff007BFC),
                              icon: const Icon(CupertinoIcons.info, color: Colors.white,),
                              text: 'Help',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 65),
                              child: line(),
                            ),
                            profileOption(
                              color: const Color(0xffFE2C55),
                              icon: const Icon(CupertinoIcons.heart_fill, color: Colors.white,),
                              text: 'Tell a Friend',
                            ),
                          ],
                        ),
                      ),
                      line(),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: Colors.black,
          floatingActionButton: (pageIndex == 3) ? FloatingActionButton(
            child: const Icon(CupertinoIcons.add),
            onPressed: (){
              setState(() {
                addImage = null;
                name = '';
                nameEditingController.clear();
                mobile = '';
                mobileEditingController.clear();
                currentStep = 0;
                showDialog(
                  context: context,
                  builder: (context){
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          content: SizedBox(
                            height: 400,
                            width: 300,
                            child: Stepper(
                              physics: const BouncingScrollPhysics(),
                              elevation: 1,
                              type: StepperType.vertical,
                              currentStep: currentStep,
                              onStepContinue: (){
                                setState((){
                                  if(currentStep == 0)
                                    {
                                      if(addImage != null)
                                        {
                                          if(currentStep < 2) currentStep++;
                                        }
                                    }
                                  else if(currentStep == 1)
                                    {
                                      if(nameKey.currentState!.validate())
                                        {
                                          if(currentStep < 2) currentStep++;
                                        }
                                    }
                                  else if(currentStep == 2)
                                    {
                                      if(mobileKey.currentState!.validate())
                                      {
                                        Navigator.pop(context);
                                      }
                                    }
                                });
                              },
                              onStepCancel: (){
                                setState((){
                                  if(currentStep > 0) currentStep--;
                                });
                              },
                              steps: [
                                Step(
                                  state: (currentStep > 0) ? StepState.complete : StepState.indexed,
                                  isActive: currentStep >= 0,
                                  title: const Text("Profile Photo",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                    ),
                                  ),
                                  subtitle: const Text("Add Profile Photo",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                    ),
                                  ),
                                  content: Stack(
                                    alignment: const Alignment(1.3,1),
                                    children: [
                                      (addImage != null) ? CircleAvatar(
                                        radius: 60,
                                        backgroundImage: FileImage(addImage!),
                                      ) : const CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Color(0xFFE5E5E5),
                                        child: Text("ADD"),
                                      ),
                                      SizedBox(
                                        height: 30,
                                        child: FloatingActionButton(
                                          onPressed: () async {
                                            XFile? pic = await ImagePicker().pickImage(source: ImageSource.camera);
                                            if(pic != null)
                                            {
                                              setState(() {
                                                addImage = File(pic.path);
                                              });
                                            }
                                          },
                                          child: const Icon(Icons.add, size: 20,),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Step(
                                  state: (currentStep > 1) ? StepState.complete : StepState.indexed,
                                  isActive: currentStep >= 1,
                                  title: const Text("Name",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                    ),
                                  ),
                                  subtitle: const Text("Enter Name",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                    ),
                                  ),
                                  content: Form(
                                    key: nameKey,
                                    child: TextFormField(
                                      keyboardType: TextInputType.name,
                                      controller: nameEditingController,
                                      validator: (val) {
                                        if(val!.isEmpty)
                                          {
                                            return "Enter Your Name";
                                          }
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Iphone",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: "Name",
                                        hintStyle: const TextStyle(
                                          fontFamily: 'Iphone',
                                          fontSize: 18,
                                          color: Color(0xff838387),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                        errorStyle: const TextStyle(
                                          fontFamily: 'Iphone',
                                          letterSpacing: 0.2,
                                        ),
                                        suffix: GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              nameEditingController.clear();
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 15),
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff8E8E93),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close_rounded,
                                              size: 15,
                                              color: Color(0xffFEFFFE),
                                            ),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(left: 15),
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          name = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Step(
                                  state: (currentStep > 2) ? StepState.complete : StepState.indexed,
                                  isActive: currentStep >= 2,
                                  title: const Text("Mobile Number",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                    ),
                                  ),
                                  subtitle: const Text("Enter Mobile Number",
                                    style: TextStyle(
                                      fontFamily: 'Iphone',
                                    ),
                                  ),
                                  content: Form(
                                    key: mobileKey,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      controller: mobileEditingController,
                                      validator: (val) {
                                        if(val!.isEmpty)
                                        {
                                          return "Enter Your Mobile No";
                                        }
                                      },
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontFamily: "Iphone",
                                        fontWeight: FontWeight.w600,
                                      ),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        hintText: "Mobile No",
                                        hintStyle: const TextStyle(
                                          fontFamily: 'Iphone',
                                          fontSize: 18,
                                          color: Color(0xff838387),
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 1,
                                        ),
                                        errorStyle: const TextStyle(
                                          fontFamily: 'Iphone',
                                          letterSpacing: 0.2,
                                        ),
                                        suffix: GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              mobileEditingController.clear();
                                            });
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(horizontal: 15),
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                              color: Color(0xff8E8E93),
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.close_rounded,
                                              size: 15,
                                              color: Color(0xffFEFFFE),
                                            ),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(left: 15),
                                      ),
                                      onChanged: (value){
                                        setState(() {
                                          mobile = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              });
            },
          ) : null,
          bottomNavigationBar: (platForm == true) ? BottomNavigationBar(
            backgroundColor: const Color(0xff171717),
            selectedItemColor: Global.blue,
            unselectedItemColor: const Color(0xffA2A2A9),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Iphone',
              fontSize: 12,
            ),
            unselectedLabelStyle: const TextStyle(
              fontFamily: 'Iphone',
            ),
            currentIndex: pageIndex,
            onTap: (val){
              setState(() {
                tabController.animateTo(val);
                pageController.animateToPage(val, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                pageIndex = val;
                (pageIndex == 2) ? camera() : null;
              });
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.data_saver_off_rounded),
                label: "Status",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone),
                label: "Calls",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.camera),
                label: "Camera",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2_fill),
                label: "Chats",
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings),
                label: "Settings",
              ),
            ],
          ) : Container(height: 0.0,),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
