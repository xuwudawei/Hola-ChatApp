import 'package:flutter/material.dart';

Color myGreen = Color(0xff4bb17b);
enum MessageType { sent, received }
List<Map<String, dynamic>> friendsList = [
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'John',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': true,
    'hasUnSeenMsgs': false,
    'unseenCount': 2,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'Paul',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': false,
    'hasUnSeenMsgs': false,
    'unseenCount': 0,
    'lastMsgTime': '18:44',
    'isOnline': false
  },
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'Mike',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': false,
    'hasUnSeenMsgs': true,
    'unseenCount': 3,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'Ben',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': true,
    'hasUnSeenMsgs': true,
    'unseenCount': 2,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'Zih',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': false,
    'hasUnSeenMsgs': true,
    'unseenCount': 4,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'Ebenezer',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': false,
    'hasUnSeenMsgs': false,
    'unseenCount': 5,
    'lastMsgTime': '18:44',
    'isOnline': true
  },
  {
    'imgUrl':
        'https://avatars1.githubusercontent.com/u/57068034?s=460&u=82af1ad2c27fa64e684418db670231c47f65deff&v=4',
    'username': 'Zack',
    'lastMsg': 'Sure, let me send it you right away.',
    'seen': false,
    'hasUnSeenMsgs': true,
    'unseenCount': 3,
    'lastMsgTime': '18:44',
    'isOnline': true
  }
];

List<Map<String, dynamic>> messages = [
  {
    'status': MessageType.received,
    'contactImgUrl':
        'https://www.inquirer.com/resizer/_GnjnOCCKM_c5nsLEhzIrY5oaRs=/0x0:1301x866/1400x932/arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/H5M36USWVBGQPODBDB3SP5QLRI.jpg',
    'contactName': 'Friend',
    'message': 'Hi mate, I\d like you to help me apply for a competition',
    'time': '08:43 AM'
  },
  {
    'status': MessageType.sent,
    'message': 'Hi, I hope you are doing great!',
    'time': '08:45 AM'
  },
  {
    'status': MessageType.sent,
    'message': 'Send me your CV, as well as your ID card details.',
    'time': '08:45 AM'
  },
  {
    'status': MessageType.received,
    'contactImgUrl':
        'https://www.inquirer.com/resizer/_GnjnOCCKM_c5nsLEhzIrY5oaRs=/0x0:1301x866/1400x932/arc-anglerfish-arc2-prod-pmn.s3.amazonaws.com/public/H5M36USWVBGQPODBDB3SP5QLRI.jpg',
    'contactName': 'Client',
    'message': 'Sure, let me send it you right away.',
    'time': '08:47 AM'
  },
  {'status': MessageType.sent, 'message': 'Ok.Sure', 'time': '08:45 AM'},
];
