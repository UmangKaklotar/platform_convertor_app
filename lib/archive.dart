import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'Global.dart';

class Archive extends StatefulWidget {
  const Archive({Key? key}) : super(key: key);

  @override
  State<Archive> createState() => _ArchiveState();
}

class _ArchiveState extends State<Archive> {
  Widget line(){
    return Container(
      height: 1,
      color: const Color(0xff2D2D30),
    );
  }
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          splashRadius: 25,
          icon: const Icon(CupertinoIcons.back),
          onPressed: (){
            setState(() {
              Navigator.pop(context);
            });
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text("Archived",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Iphone',
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            line(),
            ...Global.contactList.map((e) {
              if(e['archive']) {
                return Column(
                  children: [
                    Slidable(
                      key: UniqueKey(),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        extentRatio: 0.25,
                        dragDismissible: true,
                        closeThreshold: 0.5,
                        dismissible: DismissiblePane(onDismissed: () {
                          setState(() {
                            e['archive'] = !e['archive'];
                            print(e['archive']);
                          });
                        }),
                        children: [
                          SlidableAction(
                            onPressed: (val){
                              setState(() {
                                e['archive'] = !e['archive'];
                                print(e['archive']);
                              });
                            },
                            backgroundColor: const Color(0xff4A6FA3),
                            foregroundColor: Colors.white,
                            icon: CupertinoIcons.archivebox_fill,
                            label: "Unarchive",
                            spacing: 5,
                          ),
                        ],
                      ),
                      child: InkWell(
                        splashColor: const Color(0xff3A3A3C),
                        splashFactory: InkRipple.splashFactory,
                        onTap: (){
                          Navigator.pushNamed(context, 'chat', arguments: Global.contactList.indexOf(e));
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
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 5),
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
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
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
              return Container();
            }).toList(),
          ],
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
