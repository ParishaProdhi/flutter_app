// import 'dart:math';
// import 'dart:ui';
//
// import 'package:camera/camera.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sms/sms.dart';
//
// class accountOpening extends StatefulWidget {
//   @override
//   _accountOpeningState createState() => _accountOpeningState();
// }
//
// class _accountOpeningState extends State<accountOpening> {
//   TextEditingController phoneController = new TextEditingController();
//   TextEditingController otpOneController = new TextEditingController();
//   TextEditingController otpTwoController = new TextEditingController();
//   TextEditingController otpThreeController = new TextEditingController();
//   TextEditingController otpFourController = new TextEditingController();
//
//   var _phoneKey = GlobalKey<FormState>();
//   var _otpKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   var a;
//   int step = 0;
//
//   var phone_no;
//   List otp_no_list = ["", "", "", ""];
//   String otp_no, generated_otp;
//
//   @override
//   void initState() {
//     a = AssetImage('assets/images/back.jpg');
//     super.initState();
//   }
//
//
//   Widget center_field(int a){
//     switch (a){
//       case 0:
//         return Phone_field();
//       case 1:
//         return OTP_field();
//       case 2:
//         return Camera_field();
//       default:
//         return SizedBox.shrink();
//     }
//   }
//   Widget Camera_field(){
//     return Text("Camera");
//   }
//
//   Widget Phone_field(){
//     return Container(
//       padding: EdgeInsets.all(30),
//       child: Center(
//         child: Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
//                 border: Border.all(color: Colors.blue, width: 2, style: BorderStyle.solid)
//             ),
//             child: Column(
//               children: [
//                 Text("Enter your mobile number:"),
//                 Form(
//                   key: _phoneKey,
//                   child: TextFormField(
//                     controller: phoneController,
//                     keyboardType: TextInputType.number,
//                     maxLength: 11,
//                     autofocus: true,
//                     textAlign: TextAlign.center,
//                     validator: (val){
//                       if(val.length < 11){
//                         return "যোগাযোগের নম্বর অবশ্যই ১১ অংকের হতে হবে";
//                       }
//                     },
//                     onSaved: (val){
//                         this.phone_no = val;
//                     },
//                   ),
//                 ),
//               ],
//             )
//         ),
//       ),
//     );
//   }
//   Widget OTP_field(){
//     return Container(
//       padding: EdgeInsets.all(30),
//       child: Center(
//         child: Container(
//             padding: EdgeInsets.all(20),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.elliptical(20, 20)),
//                 border: Border.all(color: Colors.blue, width: 2, style: BorderStyle.solid)
//             ),
//             child: Form(
//               key: _otpKey,
//               child: Column(
//                 children: <Widget>[
//                   Text("Please enter the OTP sent to your phone:"),
//                   Row(
//                     children: <Widget>[
//                       Text('   '),
//                       SizedBox(
//                         width: 50,
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                           ],
//
//                           textAlign: TextAlign.center,
//                           onChanged: (_) => FocusScope.of(context).nextFocus(),
//                           autofocus: true,
//                           onSaved: (value){
//                             this.otp_no_list[0] = value;
//                             otp_no += value;
//                           },
//                         ),
//                       ),
//                       Text('   '),
//                       SizedBox(
//                         width: 50,
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                           ],
//                           textAlign: TextAlign.center,
//                           onChanged: (_) => FocusScope.of(context).nextFocus(),
//                           onSaved: (value){
//                             otp_no += value;
//                           },
//                         ),
//                       ),
//                       Text('   '),
//                       SizedBox(
//                         width: 50,
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                           ],
//                           textAlign: TextAlign.center,
//                           onChanged: (_) => FocusScope.of(context).nextFocus(),
//                           onSaved: (value){
//                             otp_no += value;
//                           },
//                         ),
//                       ),
//                       Text('   '),
//                       SizedBox(
//                         width: 50,
//                         child: TextFormField(
//                           keyboardType: TextInputType.number,
//                           inputFormatters: [
//                             LengthLimitingTextInputFormatter(1),
//                           ],
//                           textAlign: TextAlign.center,
//                           onChanged: (_) => FocusScope.of(context).unfocus(),
//                           onSaved: (value){
//                             otp_no += value;
//                           },
//
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             )
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     otp_no = "";
//     return Container(
//       decoration: BoxDecoration(
//         // color: Colors.white
//           image: DecorationImage(
//             image: a,
//             fit: BoxFit.fill,
//           )
//       ),
//     child: Scaffold(
//         key: _scaffoldKey,
//     backgroundColor: Colors.transparent,
//     appBar: AppBar(
//     centerTitle: true,
//     title: Text("প্রাথমিক তথ্যাবলী"),
//     backgroundColor: Colors.transparent,
//     ),
//     body:  Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//
//         children: <Widget>[
//           center_field(step),
//           step>2 ? SizedBox.shrink():
//           Container(
//             height: 50,
//             width: 150,
//             child: RaisedButton(
//               color: Colors.orange,
//               child: Text(
//                 'পরবর্তী',
//                 textAlign: TextAlign.justify,
//                 style: TextStyle(fontSize: 20),
//               ),
//               onPressed: (){
//                 print(step);
//                 setState(() {
//                   switch(step){
//                     case 0:
//                       return {
//                       if(_phoneKey.currentState.validate()){
//                         _phoneKey.currentState.save(),
//                         print(this.phone_no),
//                         // sendOTP(),
//                         step++,
//                         step++,
//                       }};
//                     case 1:
//                       return {
//                           _otpKey.currentState.save(),
//                           (this.otp_no == this.generated_otp) ? step++ : print("wrong otp entered"),
//                           print(this.otp_no)
//                       };
//                     case 2:
//                       return{
//
//                       };
//                     default:
//                       return {
//                       };
//                   }
//                 });
//               },
//             ),
//           ),
//         ],
//       ),
//     )
//     )
//     );
//   }
//
//   int generateOTP() {
//     return 1000 + Random().nextInt(9999 - 1000);
//   }
//
//   sendOTP() {
//     int otp = generateOTP();
//     this.generated_otp = otp.toString();
//     SmsSender sender = new SmsSender();
//     sender.sendSms(new SmsMessage(
//         "+88"+this.phone_no, 'Your OTP is : ' + otp.toString()));
//
//   }
// }