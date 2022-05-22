import "package:flutter/material.dart";

class NotificationBlock extends StatefulWidget {
  const NotificationBlock({Key? key}) : super(key: key);

  @override
  _NotificationBlockState createState() => _NotificationBlockState();
}

class _NotificationBlockState extends State<NotificationBlock> {
  List<String> notificationDummy = [
    "Notification 1",
    "Notification 2",
  ];

  List<String> notificationSubDummy = [
    "Notification subtitle 1",
    "Notification subtitle 2",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Notifications",
          style: TextStyle(fontSize: 30),
        ),
        Expanded(
            child: ListView.builder(
              shrinkWrap: true,
          itemCount: notificationDummy.length,
          itemBuilder: (_, index) {
            return Card(
              child: Row(
                children: [
                  Image.asset(
                    ("image/sos_button.png"),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            );
          },
        ))
      ],
    );
  }
}
