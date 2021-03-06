import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/widgets/docs.dart';
import 'package:flutter_app/widgets/home.dart';
import 'package:flutter_app/widgets/pdfContainer.dart';
import 'package:flutter_app/widgets/textContainer.dart';
import 'listContainer.dart';
import 'menuContainer.dart';
import 'package:path_provider/path_provider.dart';

var id;

class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  List<String> path = ["", "", "", "", "", "", "", "", "", "", "", "", ""];
  String assetPDFPath = "";
  var a;
  void initState() {
    super.initState();
    a = new Image.asset(
        'assets/images/bkbIcon.png',
        fit: BoxFit.cover);
    getFileFromAsset("assets/documents/crop_loan_calender.pdf", 0).then((f) {
      setState(() {
        path[0] = f.path;
        print(path[0]);
      });
    });
    getFileFromAsset("assets/documents/loan_interest_rate.pdf", 1).then((f) {
      setState(() {
        path[1] = f.path;
        print(path[1]);
      });
    });
    getFileFromAsset("assets/documents/other_loans_interest_rate.pdf", 2).then((f) {
      setState(() {
        path[2] = f.path;
        print(path[2]);
      });
    });
    getFileFromAsset("assets/documents/rules_for_loan.pdf", 3).then((f) {
      setState(() {
        path[3] = f.path;
        print(path[3]);
      });
    });
    getFileFromAsset("assets/documents/documents_required_for_sme.pdf", 4).then((f) {
      setState(() {
        path[4] = f.path;
        print(path[4]);
      });
    });
    getFileFromAsset("assets/documents/documents_required_for_current_or_interest_loan.pdf", 5).then((f) {
      setState(() {
        path[5] = f.path;
        print(path[5]);
      });
    });
    getFileFromAsset("assets/documents/sme_loan.pdf", 6).then((f) {
      setState(() {
        path[6] = f.path;
        print(path[6]);
      });
    });
    getFileFromAsset("assets/documents/form_for_crop_loan.pdf", 7).then((f) {
      setState(() {
        path[7] = f.path;
        print(path[7]);
      });
    });
    getFileFromAsset("assets/documents/form_for_current_crop_loan.pdf", 8).then((f) {
      setState(() {
        path[8] = f.path;
        print(path[8]);
      });
    });
    getFileFromAsset("assets/documents/form_for_mortgaged_crop_loan.pdf", 9).then((f) {
      setState(() {
        path[9] = f.path;
        print(path[9]);
      });
    });
    getFileFromAsset("assets/documents/form_for_current_interest_loan.pdf", 10).then((f) {
      setState(() {
        path[10] = f.path;
        print(path[10]);
      });
    });
    getFileFromAsset("assets/documents/form_for_project_loan.pdf", 11).then((f) {
      setState(() {
        path[11] = f.path;
        print(path[11]);
      });
    });
    getFileFromAsset("assets/documents/form_for_sme_loan.pdf", 12).then((f) {
      setState(() {
        path[12] = f.path;
        print(path[12]);
      });
    });

  }
  Future<File> getFileFromAsset(String asset, int index) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf_$index.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      throw Exception("Error opening asset file");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: a,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('হোম'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => home()))
            },
          ),
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text('সিটিজেন চার্টার'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          textContainer(texts[0][0], texts[0][1])))
            },
          ),
          ListTile(
            leading: Icon(Icons.money_rounded),
            title: Text('ঋণ'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuContainer([
                            [
                              "সাধারন তথ্যাবলী",
                              listContainer([
                                [
                                  "ঋণ আবেদনকারীর যোগ্যতা",
                                  textContainer(texts[1][0], texts[1][1])
                                ],
                                [
                                  "ঋণের মৌলিক তথ্য ও পরিশোধের সময়কাল",
                                  textContainer(texts[2][0], texts[2][1])
                                ],
                                [
                                  "ফসল ঋণ বিতরন পঞ্জিকা",
                                  pdfContainer(path: path[0])
                                  // pdfContainer(path: path[0])
                                  // textContainer(
                                  //     "this led to nothing or to a PDF file in the previous application",
                                  //     "")
                                ],
                                [
                                  "ঋণের সুদ",
                                  listContainer([
                                    [
                                      "ঋণের সুদের হার (শস্য)",
                                      pdfContainer(path: path[1])
                                    ],
                                    [
                                      "ঋণের সুদের হার (অন্যান্য)",
                                      pdfContainer(path: path[2])
                                    ]
                                  ])
                                ],
                                [
                                  "ঋণের নিয়মাচার",
                                  pdfContainer(path: path[3])
                                ]
                              ])
                            ],
                            [
                              "আবেদনের প্রয়োজনীয় কাগজপত্র",
                              listContainer([
                                [
                                  "শস্য ঋণের প্রয়েজনীয় কাগজপত্র",
                                  textContainer(texts[3][0], texts[3][1])
                                ],
                                [
                                  "মেয়াদী ঋণের প্রয়েজনীয় কাগজপত্র",
                                  textContainer(texts[4][0], texts[4][1])
                                ],
                                [
                                  "এসএমই(SME) ঋণ",
                                  listContainer([
                                    [
                                      "SME ঋণ প্রয়োজনীয় কাগজপত্র",
                                      pdfContainer(path: path[4])
                                    ],
                                    [
                                      "প্রকল্প ঋণ /চলতি মুলধন ঋণ/চলতি মুলধন ঋণ প্রয়োজনীয় কাগজপত্র",
                                      pdfContainer(path: path[5])
                                    ]
                                  ])
                                ]
                              ])
                            ],
                            [
                              "ঋণের প্রকারভেদ",
                              listContainer([
                                [
                                  "স্বল্প মেয়াদী ঋণ",
                                  listContainer([
                                    [
                                      "শস্য ঋণ",
                                      listContainer([
                                        [
                                          "রোপা আমন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "বোরো",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "গম",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আলু",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আখ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "সরিষা/বাদাম",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "ডাল/শীত কালীন শাকসবজি",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আউশ/বোনা আমন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "পাট",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "ভুট্টা",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "তিল/গ্রীষ্মকালীন শাক সবজী",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "তুলা",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আদা/কচু",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "মৎস্যচাষ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "চিংড়ি চাষ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "একুয়াকালচার",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "রেণু উৎপাদন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "লবণ চাষ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "কলাচাষ ও বিবিধ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "শস্যগুদাম ও বাজারজাতকরণ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ]
                                      ])
                                    ],
                                    [
                                      "চা উৎপাদন ঋণ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "নগদ মুলধন ঋণ/চলতি মুলধন ঋণ",
                                      listContainer([
                                        [
                                          "রপ্তানী ঋণ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "মৎস্য প্রক্রিয়াজাতকরণ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আলু সংরক্ষণ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "কৃষি পণ্যের বিপণন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "সার ও কীটনাশক ঔষধের ডিলার , কৃষি পণ্যের ক্ষুদ্র ব্যবসায়ী",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "অন্যান্য (এসএমই খাত সহ)",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ]
                                      ])
                                    ],
                                    [
                                      "আর্থ-সামাজিক কার্যাবলী-আইফাদ/স্বনির্ভর ঋণ কর্মসূচী",
                                      listContainer([
                                        [
                                          "রোপা আমন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "বোরো",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "গম",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আলু",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আখ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "সরিষা/বাদাম",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "ডাল/শীত কালীন শাকসবজি",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আউশ/বোনা আমন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "পাট",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "ভুট্টা",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "তিল/গ্রীষ্মকালীন শাক সবজী",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "তুলা",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "আদা/কচু",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "মৎস্যচাষ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "চিংড়ি চাষ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "একুয়াকালচার",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "রেণু উৎপাদন",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "লবণ চাষ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "কলাচাষ ও বিবিধ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ],
                                        [
                                          "শস্যগুদাম ও বাজারজাতকরণ",
                                          textContainer(
                                              "this led to nothing or to a PDF file in the previous application",
                                              "")
                                        ]
                                      ])
                                    ]
                                  ])
                                ],
                                [
                                  "মধ্যম মেয়াদী ঋণ",
                                  listContainer([
                                    [
                                      "হালের বলদ/গ্রামীন যানবাহন",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "ফল ও অন্যান্য অর্থকরী ফসলের বাগান/পানবরজ/মিশ্র খামার",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "রেশম চাষ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "স্বনির্ভর ঋণ কর্মসূচী/শিক্ষিত বেকার যুবক উন্নয়ন কর্মসূচী",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "সেচ যন্ত্রপাতি",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "পুকুরে মৎস্য চাষ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "চিংড়ি চাষ (প্রকল্প আকারে)",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "সামুদ্রিক মৎস্য চাষ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "আর্থ-সামাজিক কার্যাবল-আইফাদ আর, এফ, পি/স্বনির্ভর ঋণ কর্মসূচী ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "কৃষি যন্ত্রপাতি/খামার যন্ত্রপাতি ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "গাভী পালন/হাঁস-মুরগী পালন/ছাগল পালন/গরু মোটাতাজাকরণ/হাঁসের খামার",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "কুটির শিল্প/তাঁত শিল্প/পল্লী বিদ্যুতায়ন",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ]
                                  ])
                                ],
                                [
                                  "দীর্ঘ মেয়াদী ঋণ",
                                  listContainer([
                                    [
                                      "কৃষি ভিত্তক শিল্প",
                                      listContainer([
                                        [
                                          "দুগ্ধ খামার",
                                          "this led to nothing or to a PDF file in the previous application"
                                        ],
                                        [
                                          "গবাদী পশুর খামার",
                                          "this led to nothing or to a PDF file in the previous application"
                                        ],
                                        [
                                          "হাঁস-মুরগী পালন/খামার",
                                          "this led to nothing or to a PDF file in the previous application"
                                        ],
                                        [
                                          "মৎস্য খামার",
                                          "this led to nothing or to a PDF file in the previous application"
                                        ],
                                        [
                                          "ফলের বাগান",
                                          "this led to nothing or to a PDF file in the previous application"
                                        ],
                                        [
                                          "ছোট আকারের কৃষি যন্ত্রপাতি উৎপাদন ",
                                          "this led to nothing or to a PDF file in the previous application"
                                        ]
                                      ])
                                    ],
                                    [
                                      "চা বাগান উন্নয়ন",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "রাবার চাষ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "প্রকল্প ঋণ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ]
                                  ])
                                ],
                                [
                                  "অন্যান্য ঋণ",
                                  listContainer([
                                    [
                                      "আমানতের বিপরীতে ঋণ ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "কনজ্যুমার ঋণ",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "গ্রীণ ব্যাংকিং",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "এসএমই ঋণ",
                                      pdfContainer(path: path[6])
                                    ]
                                  ])
                                ],
                                [
                                  "বৈদেশিক বাণিজ্য সম্পর্কিত ঋণ",
                                  listContainer([
                                    [
                                      "এলটিআর",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "পি এ ডি(বিল অব এক্সচেঞ্জ)",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "আইবিপি",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "প্যাকিং/ক্রেডিট",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ]
                                  ])
                                ]
                              ])
                            ],
                            [
                              "ঋণের আবেদন ফরম",
                              listContainer([
                                [
                                  "শস্য (সাধারণ)",
                                  pdfContainer(path: path[7])
                                ],
                                [
                                  "শস্য (আবর্তনশীল)",
                                  pdfContainer(path: path[8])
                                ],
                                [
                                  "শস্য (বন্ধকী)",
                                  pdfContainer(path: path[9])
                                ],
                                [
                                  "চলতি মুলধন/নগদ ",
                                  pdfContainer(path: path[10])
                                ],
                                [
                                  "প্রকল্প ঋণ",
                                  pdfContainer(path: path[11])
                                ],
                                [
                                  "এসএমই(SME)",
                                  pdfContainer(path: path[12])
                                ]
                              ])
                            ]
                          ]))),
            },
          ),
          ListTile(
            leading: Icon(Icons.attach_money_outlined),
            title: Text('আমানত'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuContainer([
                            [
                              "সঞ্চয়ী আমানত হিসাব",
                              textContainer(
                                  "this led to nothing or to a PDF file in the previous application",
                                  "")
                            ],
                            [
                              "চলতি আমানত হিসাব",
                              textContainer(
                                  "this led to nothing or to a PDF file in the previous application",
                                  "")
                            ],
                            [
                              "স্থায়ী আমানত হিসাব",
                              textContainer(
                                  "this led to nothing or to a PDF file in the previous application",
                                  "")
                            ],
                            [
                              "স্পেশাল নোটিশ ডিপোজিট",
                              textContainer(
                                  "this led to nothing or to a PDF file in the previous application",
                                  "")
                            ],
                            [
                              "মাসিক সঞ্চয়ী স্কীম",
                              textContainer(
                                  "this led to nothing or to a PDF file in the previous application",
                                  "")
                            ],
                            [
                              "প্রয়োজনীয় কাগজপত্র",
                              listContainer([
                                [
                                  "আবেদনকারীর জাতীয় পরিচয়পত্রের ফটোকপি",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "আবেদনকারীর ২ কপি পাসপোর্ট  সাইজ ছবি",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "নমিনীর জাতীয় পরিচয় পত্রের ফটোকপি ও ছবি",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "ট্রেড লাইসেন্স (প্রতিষ্ঠানের ক্ষেত্রে)",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ]
                              ])
                            ],
                            [
                              "হিসাব খোলার ফরম",
                              textContainer(
                                  "this led to nothing or to a PDF file in the previous application",
                                  "")
                            ]
                          ]))),
            },
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('বিশেষ কর্মসূচি'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          textContainer(texts[5][0], texts[5][1]))),
            },
          ),
          ListTile(
            leading: Icon(Icons.contact_page_outlined),
            title: Text('যোগাযোগ'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => textContainer(
                          "যোগাযোগ", "to fetch info from database"))),
            },
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('প্রয়োজনীয় প্রশ্ন ও উত্তর'),
            onTap: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          textContainer(texts[6][0], texts[6][1]))),
            },
          ),
        ],
      ),
    );
  }
}
