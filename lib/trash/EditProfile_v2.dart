// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:image_picker/image_picker.dart';
//
// class EditProfile extends StatefulWidget {
//
//   @override
//   _EditProfileState createState() => _EditProfileState();
// }
//
// class _EditProfileState extends State<EditProfile> {
//
//   CollectionReference _profiles = FirebaseFirestore.instance.collection(
//       'profile');
//
//
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _idController = TextEditingController();
//   var currentUser = FirebaseAuth.instance.currentUser;
//
//   Future<void> _createOrUpdate(String username, String password, String name,
//       String id) async {
//     DocumentReference documentReferencer = _profiles.doc(currentUser!.uid);
//
//     Map<String, String> data = <String, String>{
//       "name": name,
//       "password": password,
//       "username": username,
//       "user_id": id,
//     };
//     await documentReferencer
//         .set(data)
//         .whenComplete(() => print("Notes item added to the database"))
//         .catchError((e) => print(e));
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         title: Text('Edit Profile',
//           style: TextStyle(
//               fontFamily: 'Yrsa',
//               fontSize: 25,
//               color: Colors.black,
//               fontWeight: FontWeight.bold),
//
//         ),
//         centerTitle: true,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//             size: 30,
//           ),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//           future: _profiles.doc(currentUser!.uid).get(),
//           builder:
//               (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//             if (snapshot.hasData && !snapshot.data!.exists) {
//               _usernameController.text = "";
//               _passwordController.text = "";
//               _nameController.text = "";
//               _idController.text = "";
//             }
//
//             else if (snapshot.connectionState == ConnectionState.done) {
//               print("here2");
//               Map<String, dynamic> data = snapshot.data!.data() as Map<
//                   String,
//                   dynamic>;
//               _usernameController.text = data["username"];
//               _passwordController.text = data["password"];
//               _nameController.text = data["name"];
//               _idController.text = data["user_id"];
//             }
//
//
//             return SafeArea(
//               child: ListView(
//                   padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                   children: <Widget>[
//               const SizedBox(height: 10.0),
//               Column(
//                 children: <Widget>[
//                   Row(children: [
//                     const Text(
//                       '내 정보',
//                       style: TextStyle(
//                           height: 1,
//                           fontSize: 25,
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(width: 10),
//                     image != null
//                         ? ClipOval(
//                       child: Image.file(
//                         image!,
//                         fit: BoxFit.cover,
//                         width: 70,
//                         height: 70,
//                       ),
//                     )
//                         : IconButton(
//                       icon: Image.asset('image/sos_button.png'),
//                       iconSize: 70,
//                       onPressed: () {},
//                     ),
//                   ]),
//                   const SizedBox(height: 10.0),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey)),
//                     //height: 300.0,
//                     //width: 300.0,
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         TextFormField(
//                           controller: _idController,
//                           decoration: new InputDecoration(hintText: 'ID'),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please enter ID";
//                             }
//                           },
//
//                           textAlign: TextAlign.left,
//                         ),
//                         SizedBox(height: 5),
//                         TextFormField(
//                           controller: _nameController,
//                           decoration: new InputDecoration(hintText: 'Name'),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please enter Name";
//                             }
//                           },
//
//                           textAlign: TextAlign.left,
//                         ),
//                         SizedBox(height: 5),
//                         TextFormField(
//                           controller: _usernameController,
//                           decoration:
//                           new InputDecoration(hintText: 'Email'),
//                           keyboardType: TextInputType.emailAddress,
//
//                           validator: (value) =>
//                           (value!.isEmpty)
//                               ? ' Please enter email'
//                               : null,
//                           textAlign: TextAlign.left,
//                         ),
//                         SizedBox(height: 5),
//                         TextFormField(
//                           controller: _passwordController,
//                           decoration:
//                           new InputDecoration(hintText: 'Password'),
//                           obscureText: true,
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return "Please enter Password";
//                             }
//                           },
//
//                           textAlign: TextAlign.left,
//                         ),
//                         SizedBox(height: 20),
//                         // ElevatedButton(
//                         //   child: const Text('Update profile'),
//                         //   style: ElevatedButton.styleFrom(
//                         //     primary: Color(0xFFB9C98C),
//                         //     // set the background color
//                         //
//                         //     minimumSize: Size(300, 35),
//                         //   ),
//                         //
//                         //   onPressed: () {
//                         //     updateProfile(context);
//                         //   },
//                         // ),
//
//
//                         const SizedBox(
//                           height: 10,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                 children: [
//
//
//                   Container(
//                     margin: const EdgeInsets.only(left: 130.0, right: 130.0),
//                     child: ElevatedButton(
//                       child: Text('사진'),
//                       style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.all(Colors.red),
//                           shape:
//                           MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                   side: BorderSide(
//                                       color: Colors.red, width: 2.0)))),
//                       onPressed: () {
//                         // _getImage(ImageSource.gallery);
//                       },
//                     ),
//                   ),
//                   Container(
//                     margin: const EdgeInsets.only(left: 130.0, right: 130.0),
//                     child: ElevatedButton(
//                       child: Text('저장'),
//                       style: ButtonStyle(
//                           backgroundColor:
//                           MaterialStateProperty.all(Colors.red),
//                           shape:
//                           MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(18.0),
//                                   side: BorderSide(
//                                       color: Colors.red, width: 2.0)))),
//                       onPressed: () {
//                         _createOrUpdate(
//                           _idController.text,
//                           _nameController.text,
//                           _passwordController.text,
//                           _usernameController.text,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//       ),
//     );
//   }
//
//   chooseImage() async {
//     XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
//     print("file " + xfile!.path);
//     // file = File(xfile.path);
//     setState(() {});
//   }
//
//   // updateProfile(BuildContext context) async {
//   //   Map<String, dynamic> map = Map();
//   //   if (file != null) {
//   //     String url = await uploadImage();
//   //     map['profileImage'] = url;
//   //   }
//   //   map['name'] = _nameController.text;
//   //   map['email'] = _usernameController.text;
//   //   map['password'] = _passwordController.text;
//   //   map['uid'] = _idController.text;
//   //
//   //   await FirebaseFirestore.instance
//   //       .collection("user")
//   //       .doc(FirebaseAuth.instance.currentUser?.uid)
//   //       .update(map);
//   //   Navigator.pop(context);
//   // }
//
//   // Future<String> uploadImage() async {
//   //   TaskSnapshot taskSnapshot = await FirebaseStorage.instance
//   //       .ref()
//   //       .child("profile_picture")
//   //       .child(
//   //       FirebaseAuth.instance.currentUser!.uid + "_" + basename(file.path))
//   //       .putFile(file);
//   //
//   //   return taskSnapshot.ref.getDownloadURL();
//   // }
//
// // Future<void> registerAccount(
// //     String email,
// //     String displayName,
// //     String password,
// //     String name,
// //     void Function(FirebaseAuthException e) errorCallback) async {
// //   try {
// //     var credential = await FirebaseAuth.instance
// //         .createUserWithEmailAndPassword(email: email, password: password);
// //     await credential.user!.updateDisplayName(displayName);
// //   } on FirebaseAuthException catch (e) {
// //     errorCallback(e);
// //   }
// //   FirebaseFirestore.instance
// //       .collection('user')
// //       .doc(FirebaseAuth.instance.currentUser!.uid)
// //       .set(<String, dynamic>{
// //     'image':
// //     "https://firebasestorage.googleapis.com/v0/b/yorijori-52f2a.appspot.com/o/defaultProfile.png?alt=media&token=127cd072-80b8-4b77-ab22-a50a0dfa5206",
// //     'email': email,
// //     'name': name,
// //     'id': displayName,
// //     'password': password,
// //     'followers': "20",
// //     'uid': FirebaseAuth.instance.currentUser!.uid,
// //   });
// // }
//
// }
//
