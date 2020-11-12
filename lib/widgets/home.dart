import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import 'form.dart';
import 'nav-drawer.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  String assetPDFPath = "";
  String urlPDFPath = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/back.jpg'),
        fit: BoxFit.fill,
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            title: Text('Krishi Loan'),
            backgroundColor: Colors.transparent,
          ),
          drawer: NavDrawer(),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "বাংলাদেশ কৃষি ব্যাংক-এ আপনাকে স্বাগতম!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "বাংলাদেশ কৃষি ব্যাংক (বিকেবি) একটি শতভাগ রাষ্ট্রীয় মালিকানাধীন বিশেষায়িত ব্যাংক।১৯৭৩ সালে রাস্ট্রপতি আদেশ নং-২৭ বলে প্রতিষ্ঠিত বাংলাদেশের কৃষির মতো প্রকৃতি নির্ভর অনিশ্চিত এবং ঝুঁকিপূর্ণ খাতে অর্থায়নের জন্য দেশের বৃহত্তম বিশেষায়িত ব্যাংক।",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    " আমানত,ঋণ,বৈদেশিক বানিজ্যসহ সব ধরনের আধুনিক ব্যাংকিং কার্যক্রম পরিচালনা করে বাংলাদেশ কৃষি ব্যাংক।গ্রাম-গঞ্জের ১০৩৮টি শাখার মধ্যে প্রায় ৫২০টি অন-লাইন শাখার মাধ্যমে বিশ্বের যে কোন দেশের প্রবাসীদের রেমিট্যান্সের টাকা দ্রুততম সময়ে স্বজনদের দোরগোড়ায় পৌঁছে দিচ্ছে।",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    "ঢাকা, চট্টগ্রাম, সিলেট,  খুলনা ও ময়মনসিংহ শহরে এটিএম বুথের মাধ্যমে ২৪ ঘন্টা ব্যাংকিং সেবা প্রদান করছে।ব্যাংকের নিজস্ব এটিএম বুথ ছাড়াও যে কোন ব্যাংকের এটিএম বুথ হতে টাকা উত্তোলন এবং কেনাকাটায় যে কোন পয়েন্ট অব সেলে খুব সহজেই কৃষি ব্যাংকের ডেবিট কার্ড ব্যবহার করা যায়।আধুনিক ও যুগোপযোগী ব্যাংকিং সুবিধা প্রদানের লক্ষ্যে ডিজিটালাইজেশনে বাংলাদেশ কৃষি ব্যাংক অনেকদুর এগিয়ে আছে। ",
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: 300,
                  child: RaisedButton(
                    color: Colors.orange,
                    child: Text(
                      'আমানত/ঋণের আবেদন',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FormPage()));
                    },
                  ),
                ),
                SizedBox(
                  width: 40,
                ),
                Container(
                  height: 50,
                  width: 300,
                  child: RaisedButton(
                    color: Colors.orange,
                    child: Text(
                      'pdf',
                      textAlign: TextAlign.justify,
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      PDFDocument doc = await PDFDocument.fromAsset(
                          'assets/documents/crop_loan_calender.pdf');
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
