import 'dart:io';

import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/widgets/story_view.dart';

class Global{
  static Color blue = const Color(0xff34A0FE);
  static File? image, cameraImage;
  static bool status = false;
  static final storyController = StoryController();
  static List<Map<String, dynamic>> contactList = [
    {
      'name': 'Dhruvin Pandav',
      'image': 'build/image/profile1.png',
      'number': '90230 56209',
      'storyTime': '1h ago',
      'mes': 'Ok 👍🏼',
      'time': '8:35 PM',
      'no': '3',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Dhruvin Pandav", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile1.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Umang Kaklotar',
      'image': 'build/image/profile2.png',
      'number': '84691 86173',
      'storyTime': '1h ago',
      'mes': '📷 Sent a Photo',
      'time': '8:30 PM',
      'no': '2',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Umang Kaklotar", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile2.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Akash Patel',
      'image': 'build/image/profile3.png',
      'number': '93288 95180',
      'storyTime': '3h ago',
      'mes': 'Yes',
      'time': '7:12 PM',
      'no': '1',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Akash Patel", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile3.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Roshni Lungiwala',
      'image': 'build/image/profile4.png',
      'number': '90992 92801',
      'storyTime': '5h ago',
      'mes': 'Saru 😊',
      'time': '4:20 PM',
      'no': '3',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Roshni Lungiwala", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile4.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Shreya Vaghasiya',
      'image': 'build/image/profile5.png',
      'number': '90239 58448',
      'storyTime': '7h ago',
      'mes': 'Oy mare error aave che 😓',
      'time': '2:49 PM',
      'no': '4',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Shreya Vaghasiya", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile5.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Sahil Savani',
      'image': 'build/image/profile6.png',
      'number': '99044 55157',
      'storyTime': '10h ago',
      'mes': 'Ha Bhai 🙏🏼',
      'time': '12:10 PM',
      'no': '4',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Sahil Savani", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile6.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Akshay Gabani',
      'image': 'build/image/profile7.png',
      'number': '70698 28200',
      'storyTime': '12h ago',
      'mes': 'Okay 👍🏼',
      'time': '11:08 AM',
      'no': '8',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Akshay Gabani", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile7.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Sanjay Tarsariya',
      'image': 'build/image/profile8.png',
      'number': '97257 93219',
      'storyTime': '14h ago',
      'mes': 'Aav Niche 🙄',
      'time': '7:55 AM',
      'no': '11',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Sanjay Tarsariya", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile8.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Jaivik Moradiya',
      'image': 'build/image/profile9.png',
      'number': '78020 72172',
      'storyTime': '16h ago',
      'mes': 'Bol',
      'time': '2:23 AM',
      'no': '1',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Jaivik Moradiya", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile9.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Varun Ghevariya',
      'image': 'build/image/profile10.png',
      'number': '94091 52511',
      'storyTime': '20h ago',
      'mes': 'Thanks Bro 🙏🏼',
      'time': 'Yesterday',
      'no': '2',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Varun Ghevariya", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile10.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Tirth Gabani',
      'image': 'build/image/profile11.png',
      'number': '70165 47058',
      'storyTime': '21h ago',
      'mes': 'Good Morning 🌞',
      'time': 'Wednesday',
      'no': '4',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Tirth Gabani", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile11.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
    {
      'name': 'Hinal Ghelani',
      'image': 'build/image/profile12.png',
      'number': '90997 78340',
      'storyTime': '24h ago',
      'mes': 'Hello 🙋🏼',
      'time': 'Tuesday',
      'no': '2',
      'archive': false,
      'pin': false,
      'story': [
        StoryItem.text(title: "Hinal Ghelani", backgroundColor: Colors.blue, textStyle: const TextStyle(fontFamily: 'Iphone', fontSize: 25)),
        StoryItem.pageProviderImage(const AssetImage('build/image/profile12.png')),
        StoryItem.pageVideo('https://www.instagram.com/reel/ClgcHCGhLNK/', controller: storyController),
      ],
      'seen': false,
    },
  ];
}

class Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;

  const Message({
    required this.text,
    required this.date,
    required this.isSentByMe,
  });
}