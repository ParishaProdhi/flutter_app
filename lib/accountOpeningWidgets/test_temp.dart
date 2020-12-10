// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class FormPage extends StatefulWidget {
//   @override
//   _FormPageState createState() => _FormPageState();
// }
//
// class _FormPageState extends State<FormPage> {
//   var formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   var phone;
//   var a;
//   void initState() {
//     a = AssetImage('assets/images/back.jpg');
//   }
//   Future<void> handleSubmit() async {
//     if (formKey.currentState.validate()) {
//       formKey.currentState.save();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final node = FocusScope.of(context);
//     return Container(
//         decoration: BoxDecoration(
//           // color: Colors.white
//             image: DecorationImage(
//               image: a,
//               fit: BoxFit.fill,
//             )
//         ),
//         child: Scaffold(
//           key: _scaffoldKey,
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             centerTitle: true,
//             title: Text("প্রাথমিক তথ্যাবলী"),
//             backgroundColor: Colors.transparent,
//           ),
//           body: ListView(children: <Widget>[
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Form(
//                 key: formKey,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(4, 4, 0, 0),
//                       child: TextFormField(
//                         // controller: phoneCtrl,
//                         keyboardType: TextInputType.number,
//                         maxLength: 11,
//                         decoration: InputDecoration(labelText: 'যোগাযোগ'),
//                         validator: (value) {
//                           if (value.length < 11)
//                             return ("যোগাযোগের নম্বর অবশ্যই ১১ অংকের হতে হবে");
//                         },
//                         onSaved: (value) {
//                           this.phone = value;
//                         },
//                         onEditingComplete: () => node.nextFocus(),
//                       ),
//                     ),
//                     Container(
//                       height: 50,
//                       width: 150,
//                       child: RaisedButton(
//                         color: Colors.orange,
//                         child: Text(
//                           'দাখিল করুন',
//                           textAlign: TextAlign.justify,
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         onPressed: handleSubmit,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ]),
//         ));
//   }
// }
