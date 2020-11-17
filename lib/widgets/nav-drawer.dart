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
  String cropLoanCalenderPath = "", cropLoanCalenderUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fcrop_loan_calender.pdf?alt=media&token=156a584c-a5b6-4c9f-99f4-28941281e041",
      documentsRequiredForCurrentOrInterestLoanPath = "",documentsRequiredForCurrentOrInterestLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fdocuments_required_for_current_or_interest_loan.pdf?alt=media&token=19938dd4-570b-43ce-a444-0f5bc6546541",
      documentsRequiredForSmePath = "",documentsRequiredForSmeUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fdocuments_required_for_sme.pdf?alt=media&token=1d89e4bb-de1a-4e9d-9095-cf2353f2517d",
      formForCropLoanPath = "",formForCropLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fform_for_crop_loan.pdf?alt=media&token=0f1ecbcb-476f-40d4-9251-716a01232bc0",
      formForCurrentCropLoanPath = "",formForCurrentCropLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fform_for_current_crop_loan.pdf?alt=media&token=d05f8d80-71f6-4906-90d1-65b824638cfe",
      formForCurrentInterestLoanPath = "",formForCurrentInterestLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fform_for_current_interest_loan.pdf?alt=media&token=900c3fc8-ff41-4b10-8dd5-1ca7e495e18f",
      formForMortgagedCropLoanPath = "",formForMortgagedCropLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fform_for_mortgaged_crop_loan.pdf?alt=media&token=a1384672-0393-4cd6-b7b4-290d34b385c5",
      formForProjectLoanPath = "",formForProjectLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fform_for_project_loan.pdf?alt=media&token=0cfed417-3501-473b-9177-de58002b410c",
      formForSmeLoanPath = "",formForSmeLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fform_for_sme_loan.pdf?alt=media&token=32a125d1-ffc2-4d20-a70b-e07a8a00036d",
      loanInterestRatePath = "", loanInterestRateUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Floan_interest_rate.pdf?alt=media&token=222a478e-6288-4ee7-aa9f-d6665ab22e61",
      otherLoansInterestRatePath = "",otherLoansInterestRateUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fother_loans_interest_rate.pdf?alt=media&token=00f10e7d-fe10-4f4a-bdae-7d50aa9c88a9",
      rulesForLoanPath = "",  rulesForLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Frules_for_loan.pdf?alt=media&token=034aaf9b-dfe2-4ec8-b77e-3c8236f5c0aa",
      smeLoanPath = "", smeLoanUrl = "https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2Fdocuments%2Fsme_loan.pdf?alt=media&token=0132e253-9336-4e8f-83cb-0451ea416402";

  String assetPDFPath = "";
  var a;
  void initState() {
    super.initState();
    a = new Image.network(
        'https://firebasestorage.googleapis.com/v0/b/loandepositinfo.appspot.com/o/assets%2FbkbIcon.png?alt=media&token=887885bd-fc97-4187-af91-b39ec0f35d2a',
        fit: BoxFit.cover);
    getFileFromUrl(cropLoanCalenderUrl).then((f) {
      setState(() {
        cropLoanCalenderPath = f.path;
      });
    });
    getFileFromUrl(documentsRequiredForCurrentOrInterestLoanUrl).then((f) {
      setState(() {
        documentsRequiredForCurrentOrInterestLoanPath = f.path;
      });
    });
    getFileFromUrl(documentsRequiredForSmeUrl).then((f) {
      setState(() {
        documentsRequiredForSmePath = f.path;
      });
    });
    getFileFromUrl(formForCropLoanUrl).then((f) {
      setState(() {
        formForCropLoanPath = f.path;
      });
    });
    getFileFromUrl(formForCurrentCropLoanUrl).then((f) {
      setState(() {
        formForCurrentCropLoanPath = f.path;
      });
    });
    getFileFromUrl(formForCurrentInterestLoanUrl).then((f) {
      setState(() {
        formForCurrentInterestLoanPath = f.path;
      });
    });
    getFileFromUrl(formForMortgagedCropLoanUrl).then((f) {
      setState(() {
        formForMortgagedCropLoanPath = f.path;
      });
    });
    getFileFromUrl(formForProjectLoanUrl).then((f) {
      setState(() {
        formForProjectLoanPath = f.path;
      });
    });
    getFileFromUrl(formForSmeLoanUrl).then((f) {
      setState(() {
        formForSmeLoanPath = f.path;
      });
    });
    getFileFromUrl(loanInterestRateUrl).then((f) {
      setState(() {
        loanInterestRatePath = f.path;
      });
    });
    getFileFromUrl(otherLoansInterestRateUrl).then((f) {
      setState(() {
        otherLoansInterestRatePath = f.path;
      });
    });
    getFileFromUrl(rulesForLoanUrl).then((f) {
      setState(() {
        rulesForLoanPath = f.path;
      });
    });
    getFileFromUrl(smeLoanUrl).then((f) {
      setState(() {
        smeLoanPath = f.path;
      });
    });

  }

  Future<io.File> getFileFromUrl(String url) async {
    try {
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      io.File file = io.File("${dir.path}/mypdf.pdf");

      io.File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening file");
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
                                  pdfContainer(path: cropLoanCalenderPath)
                                  // textContainer(
                                  //     "this led to nothing or to a PDF file in the previous application",
                                  //     "")
                                ],
                                [
                                  "ঋণের সুদ",
                                  listContainer([
                                    [
                                      "ঋণের সুদের হার (শস্য)",
                                      pdfContainer(path: loanInterestRatePath)
                                    ],
                                    [
                                      "ঋণের সুদের হার (অন্যান্য)",
                                      pdfContainer(path: otherLoansInterestRatePath)
                                    ]
                                  ])
                                ],
                                [
                                  "ঋণের নিয়মাচার",
                                  pdfContainer(path: rulesForLoanPath)
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
                                      pdfContainer(path: documentsRequiredForSmePath)
                                    ],
                                    [
                                      "প্রকল্প ঋণ /চলতি মুলধন ঋণ/চলতি মুলধন ঋণ প্রয়োজনীয় কাগজপত্র",
                                      pdfContainer(path: documentsRequiredForCurrentOrInterestLoanPath)
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
                                      pdfContainer(path: smeLoanPath)
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
                                  pdfContainer(path: formForCropLoanPath)
                                ],
                                [
                                  "শস্য (আবর্তনশীল)",
                                  pdfContainer(path: formForCurrentCropLoanPath)
                                ],
                                [
                                  "শস্য (বন্ধকী)",
                                  pdfContainer(path: formForMortgagedCropLoanPath)
                                ],
                                [
                                  "চলতি মুলধন/নগদ ",
                                  pdfContainer(path: formForCurrentInterestLoanPath)
                                ],
                                [
                                  "প্রকল্প ঋণ",
                                  pdfContainer(path: formForProjectLoanPath)
                                ],
                                [
                                  "এসএমই(SME)",
                                  pdfContainer(path: formForSmeLoanPath)
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
