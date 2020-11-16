import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/docs.dart';
import 'package:flutter_app/widgets/home.dart';
import 'package:flutter_app/widgets/pdfContainer.dart';
import 'package:flutter_app/widgets/textContainer.dart';
import 'package:path_provider/path_provider.dart';
import 'listContainer.dart';
import 'menuContainer.dart';

var id;

class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String assetPDFPath = "";
  var a;
  void initState() {
    super.initState();
    a = new Image.network(
        'https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2FbkbIcon.png?alt=media&token=887885bd-fc97-4187-af91-b39ec0f35d2a',
        fit: BoxFit.cover);
    getFileFromAsset("assets/json/crop_loan_calender.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });
  }

  Future<io.File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      io.File file = io.File("${dir.path}/mypdf.pdf");

      io.File assetFile = await file.writeAsBytes(bytes);
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
                                  pdfContainer(path: assetPDFPath)
                                  // textContainer(
                                  //     "this led to nothing or to a PDF file in the previous application",
                                  //     "")
                                ],
                                [
                                  "ঋণের সুদ",
                                  listContainer([
                                    [
                                      "ঋণের সুদের হার (শস্য)",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "ঋণের সুদের হার (অন্যান্য)",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ]
                                  ])
                                ],
                                [
                                  "ঋণের নিয়মাচার",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
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
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
                                    ],
                                    [
                                      "প্রকল্প ঋণ /চলতি মুলধন ঋণ/চলতি মুলধন ঋণ প্রয়োজনীয় কাগজপত্র",
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
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
                                      textContainer(
                                          "this led to nothing or to a PDF file in the previous application",
                                          "")
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
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "শস্য (আবর্তনশীল)",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "শস্য (বন্ধকী)",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "চলতি মুলধন/নগদ ",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "প্রকল্প ঋণ",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
                                ],
                                [
                                  "এসএমই(SME)",
                                  textContainer(
                                      "this led to nothing or to a PDF file in the previous application",
                                      "")
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
