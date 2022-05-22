import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

// import 'package:flutter_chat_app/models/room_model.dart';
// import 'package:flutter_chat_app/models/user_model.darimport '../Provider/scheduleProvider.dart';

import '../Provider/scheduleProvider.dart';
import '../UserModel/user_model.dart';
import 'EditProfile.dart';
import 'login.dart';

class FriendList extends StatefulWidget {
  const FriendList({Key? key}) : super(key: key);

  @override
  _FriendListState createState() => _FriendListState();
}

class _FriendListState extends State<FriendList> {
  User? user = FirebaseAuth.instance.currentUser;
  bool status = false;
  bool month = false;
  final List<Meeting> meetings = ScheduleProvider().getSchedules;
  final _formKey = GlobalKey<FormState>();
  final CalendarController _controller = CalendarController();
  var currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference _users = FirebaseFirestore.instance.collection('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawerScrimColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(color: Colors.black),
        ),
        //centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0.0,
        leading: Builder(
          builder: (context) =>
              IconButton(
                color: Colors.black,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications,
                color: Color(0xFFB9C98C),
              )),
          IconButton(
              onPressed: () {
                setState(() {
                  month = true;
                  if (kDebugMode) {
                    print(month);
                  }
                });
              },
              icon: const Icon(
                Icons.search,
                color: Color(0xFFB9C98C),
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_add_alt_1,
                color: Color(0xFFB9C98C),
              )),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const Padding(
              child: Text(
                'SSAP calendar',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              padding: EdgeInsets.only(top: 40, left: 10),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.account_circle,
                color: Colors.black,
              ),
              title: const Text('Yoo Isae'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Color(0xFFB9C98C),
              ),
              title: const Text(
                'Group List',
                style: TextStyle(color: Color(0xFFB9C98C)),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.people,
                color: Colors.black,
              ),
              title: const Text('My Friend List'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FriendList()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color(0xFFB9C98C),
              ),
              title: const Text('Settings'),
              onTap: () {},
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  padding: const EdgeInsets.only(left: 16),
                  child: const Text(
                    'Pubic/Private View',
                    style: TextStyle(),
                  )),
              Container(
                padding: const EdgeInsets.only(right: 16),
                child: FlutterSwitch(
                  onToggle: (val) {
                    setState(() {
                      status = !status;
                    });
                  },
                  value: status,
                  width: 40.0,
                  height: 20.0,
                  valueFontSize: 10.0,
                  toggleSize: 15.0,
                  borderRadius: 30.0,
                  toggleColor: Colors.white,
                  activeColor: const Color(0xFFB9C98C),
                ),
              ),
            ]),
            ListTile(
              title: const Text('Sign out'),
              onTap: () {Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginWidget()),);},
            ),
          ],
        ),
      ),
      body:
      // Container(
      //     color: Colors.white,
      //     child: Column(children: [
      //           FutureBuilder<DocumentSnapshot>(
      //           future: _users.doc(currentUser!.uid).get(),
      //           builder:
      //           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
      //
      //           return Card(
      //           margin: EdgeInsets.all(10),
      //           child: ListTile(
      //           leading: CircleAvatar(
      //           radius: 32,
      //           backgroundImage:
      //           NetworkImage(snapshot!.data('image')),
      //           ),
      //           title: Text(
      // snapshot['name'].toString() +
      //           " (" +
      // snapshot['id'].toString() +
      //           ")"),
      //           // subtitle:
      //           ),
      //           );
      //
      //
      //         ),

      // const Divider(),
      StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("user")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .collection('Friend')
              .get()
              .asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.docs.length == 0) {
                return Text("No Friends Found");
              }
              return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                     FriendModel friendModel = FriendModel.fromMap(
                        snapshot.data?.docs[index].data());
                    final DocumentSnapshot documentSnapshot =
                    snapshot.data!.docs[index];
                    // if (friendModel.id ==
                    //     FirebaseAuth.instance.currentUser?.uid) {
                    //   return Container();
                    // }
                    return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                          NetworkImage(documentSnapshot['image']),
                        ),
                        title: Text(
                            documentSnapshot['name'].toString() +
                                " (" +
                                documentSnapshot['id'].toString() +
                                ")"),
                        // subtitle:
                      ),
                    );
                  });
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      // ],
      // )
    );

  }
}
