import 'package:flutter/material.dart';

import 'package:story_view/story_view.dart';
import 'Global.dart';

class StoryPageView extends StatefulWidget {
  const StoryPageView({Key? key}) : super(key: key);

  @override
  State<StoryPageView> createState() => _StoryPageViewState();
}

class _StoryPageViewState extends State<StoryPageView> {
  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;
    return Material(
      child: StoryView(
        storyItems: Global.contactList[index]['story'],
        controller: Global.storyController,
        inline: false,
        repeat: false,
        indicatorColor: Colors.white,
        progressPosition: ProgressPosition.top,
        onComplete: () {
          setState(() {
            Global.status = true;
            Global.contactList[index]['seen'] = true;
            Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
          });
        },
        onVerticalSwipeComplete: (direction){
          if(direction == Direction.down) Navigator.pop(context);
        },
        onStoryShow: (val) {},
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
