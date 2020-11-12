// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/docs.dart';
import 'package:flutter_app/widgets/home.dart';
import 'package:flutter_app/widgets/textContainer.dart';

import 'listContainer.dart';
import 'menuContainer.dart';

var id;

class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: new Image.asset('assets/bkbIcon.png', fit: BoxFit.cover),
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
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "ঋণের সুদ",
                                  listContainer([
                                    [
                                      "ঋণের সুদের হার (শস্য)",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "ঋণের সুদের হার (অন্যান্য)",
                                      textContainer("this leads to nothing", "")
                                    ]
                                  ])
                                ],
                                [
                                  "ঋণের নিয়মাচার",
                                  textContainer("this leads to nothing", "")
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
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "প্রকল্প ঋণ /চলতি মুলধন ঋণ/চলতি মুলধন ঋণ প্রয়োজনীয় কাগজপত্র",
                                      textContainer("this leads to nothing", "")
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
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "বোরো",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "গম",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আলু",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আখ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "সরিষা/বাদাম",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "ডাল/শীত কালীন শাকসবজি",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আউশ/বোনা আমন",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "পাট",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "ভুট্টা",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "তিল/গ্রীষ্মকালীন শাক সবজী",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "তুলা",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আদা/কচু",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "মৎস্যচাষ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "চিংড়ি চাষ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "একুয়াকালচার",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "রেণু উৎপাদন",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "লবণ চাষ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "কলাচাষ ও বিবিধ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "শস্যগুদাম ও বাজারজাতকরণ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ]
                                      ])
                                    ],
                                    [
                                      "চা উৎপাদন ঋণ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "নগদ মুলধন ঋণ/চলতি মুলধন ঋণ",
                                      listContainer([
                                        [
                                          "রপ্তানী ঋণ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "মৎস্য প্রক্রিয়াজাতকরণ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আলু সংরক্ষণ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "কৃষি পণ্যের বিপণন",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "সার ও কীটনাশক ঔষধের ডিলার , কৃষি পণ্যের ক্ষুদ্র ব্যবসায়ী",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "অন্যান্য (এসএমই খাত সহ)",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ]
                                      ])
                                    ],
                                    [
                                      "আর্থ-সামাজিক কার্যাবলী-আইফাদ/স্বনির্ভর ঋণ কর্মসূচী",
                                      listContainer([
                                        [
                                          "রোপা আমন",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "বোরো",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "গম",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আলু",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আখ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "সরিষা/বাদাম",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "ডাল/শীত কালীন শাকসবজি",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আউশ/বোনা আমন",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "পাট",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "ভুট্টা",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "তিল/গ্রীষ্মকালীন শাক সবজী",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "তুলা",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "আদা/কচু",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "মৎস্যচাষ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "চিংড়ি চাষ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "একুয়াকালচার",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "রেণু উৎপাদন",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "লবণ চাষ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "কলাচাষ ও বিবিধ",
                                          textContainer(
                                              "this leads to nothing", "")
                                        ],
                                        [
                                          "শস্যগুদাম ও বাজারজাতকরণ",
                                          textContainer(
                                              "this leads to nothing", "")
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
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "ফল ও অন্যান্য অর্থকরী ফসলের বাগান/পানবরজ/মিশ্র খামার",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "রেশম চাষ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "স্বনির্ভর ঋণ কর্মসূচী/শিক্ষিত বেকার যুবক উন্নয়ন কর্মসূচী",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "সেচ যন্ত্রপাতি",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "পুকুরে মৎস্য চাষ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "চিংড়ি চাষ (প্রকল্প আকারে)",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "সামুদ্রিক মৎস্য চাষ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "আর্থ-সামাজিক কার্যাবল-আইফাদ আর, এফ, পি/স্বনির্ভর ঋণ কর্মসূচী ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "কৃষি যন্ত্রপাতি/খামার যন্ত্রপাতি ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "গাভী পালন/হাঁস-মুরগী পালন/ছাগল পালন/গরু মোটাতাজাকরণ/হাঁসের খামার",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "কুটির শিল্প/তাঁত শিল্প/পল্লী বিদ্যুতায়ন",
                                      textContainer("this leads to nothing", "")
                                    ]
                                  ])
                                ],
                                [
                                  "দীর্ঘ মেয়াদী ঋণ",
                                  listContainer([
                                    [
                                      "কৃষি ভিত্তক শিল্প",
                                      listContainer([
                                        ["দুগ্ধ খামার"],
                                        ["গবাদী পশুর খামার"],
                                        ["হাঁস-মুরগী পালন/খামার"],
                                        ["মৎস্য খামার"],
                                        ["ফলের বাগান"],
                                        ["ছোট আকারের কৃষি যন্ত্রপাতি উৎপাদন "]
                                      ])
                                    ],
                                    [
                                      "চা বাগান উন্নয়ন",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "রাবার চাষ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "প্রকল্প ঋণ",
                                      textContainer("this leads to nothing", "")
                                    ]
                                  ])
                                ],
                                [
                                  "অন্যান্য ঋণ",
                                  listContainer([
                                    [
                                      "আমানতের বিপরীতে ঋণ ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "কনজ্যুমার ঋণ",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "গ্রীণ ব্যাংকিং",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "এসএমই ঋণ",
                                      textContainer("this leads to nothing", "")
                                    ]
                                  ])
                                ],
                                [
                                  "বৈদেশিক বাণিজ্য সম্পর্কিত ঋণ",
                                  listContainer([
                                    [
                                      "এলটিআর",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "পি এ ডি(বিল অব এক্সচেঞ্জ)",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "আইবিপি",
                                      textContainer("this leads to nothing", "")
                                    ],
                                    [
                                      "প্যাকিং/ক্রেডিট",
                                      textContainer("this leads to nothing", "")
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
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "শস্য (আবর্তনশীল)",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "শস্য (বন্ধকী)",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "চলতি মুলধন/নগদ ",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "প্রকল্প ঋণ",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "এসএমই(SME)",
                                  textContainer("this leads to nothing", "")
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
                              textContainer("this leads to nothing", "")
                            ],
                            [
                              "চলতি আমানত হিসাব",
                              textContainer("this leads to nothing", "")
                            ],
                            [
                              "স্থায়ী আমানত হিসাব",
                              textContainer("this leads to nothing", "")
                            ],
                            [
                              "স্পেশাল নোটিশ ডিপোজিট",
                              textContainer("this leads to nothing", "")
                            ],
                            [
                              "মাসিক সঞ্চয়ী স্কীম",
                              textContainer("this leads to nothing", "")
                            ],
                            [
                              "প্রয়োজনীয় কাগজপত্র",
                              listContainer([
                                [
                                  "আবেদনকারীর জাতীয় পরিচয়পত্রের ফটোকপি",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "আবেদনকারীর ২ কপি পাসপোর্ট  সাইজ ছবি",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "নমিনীর জাতীয় পরিচয় পত্রের ফটোকপি ও ছবি",
                                  textContainer("this leads to nothing", "")
                                ],
                                [
                                  "ট্রেড লাইসেন্স (প্রতিষ্ঠানের ক্ষেত্রে)",
                                  textContainer("this leads to nothing", "")
                                ]
                              ])
                            ],
                            [
                              "হিসাব খোলার ফরম",
                              textContainer("this leads to nothing", "")
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
