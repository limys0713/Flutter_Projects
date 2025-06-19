//Version4 - 加入搜尋中動畫提示
import 'package:finalproject_coursework/userlogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:finalproject_coursework/language_mapping.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:record/record.dart';
// import 'package:finalproject_coursework/stt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCity = textLanguage[globalLanguage.value]!['taipei']!;
  final TextEditingController _symptomController = TextEditingController();
  String responseText = '';
  bool awaitingFollowUp = false;
  int followUpCount = 0;
  List<Map<String, String>> messageHistory = [];
  bool isLoading = false;

  final List<String> cityKeys = [
    'taipei',
    'newTaipei',
    'taoyuan',
    'taichung',
    'tainan',
    'kaohsiung',
    'hsinchu',
    'miaoli',
    'changhua',
    'yunlin',
    'chiayi',
    'pingtung',
    'taitung',
    'hualien',
    'yilan',
    'keelung',
    'nantou',
  ];
  final List<String> symptomKeys = [
    'fever', 'cough', 'soreThroat', 'headache', 'runnyNose',
    'vomit', 'diarrhea', 'chestTight', 'musclePain', 'fatigue'
  ];
  // final List<String> commonSymptoms = [
  //   '發燒', '咳嗽', '喉嚨痛', '頭痛', '流鼻水',
  //   '嘔吐', '腹瀉', '胸悶', '肌肉痠痛', '全身無力'
  // ];
  Set<String> selectedSymptoms = {};

  @override
  void initState() {
    super.initState();
    globalLanguage.addListener(() {
      setState(() {
        // 轉語言時同步把 city 顯示文字也更新
        selectedCity = textLanguage[globalLanguage.value]!['taipei']!;
      });
    });
  }

  @override
  void dispose(){
    _symptomController.dispose();
    super.dispose();
  }

  // Logout onPressed function
  void logOut() async{
    // Dialog:對話框
    final wantLogout = await showDialog<bool>(  // <bool>: Used to receive true and false from TextButton
      context: context,
      builder: (context) => AlertDialog(  // Ensure action dialog
        title: Text(textLanguage[globalLanguage.value]!['logOut']!),
        content: Text(textLanguage[globalLanguage.value]!['confirmLogOut']!),
        actions: [  // Dialog button control
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(textLanguage[globalLanguage.value]!['logOut']!)),
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(textLanguage[globalLanguage.value]!['cancel']!))
        ],
      )
    );

    if(wantLogout ?? false){  // if it is null, then false; otherwise look at the value(true or false)
      await FirebaseAuth.instance.signOut();  // Logout
      if(!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const UserLogin()), // Link to UserLogin page
        (route) => false
      );
    }
  }

  Future<void> getRecommendation(String userInput) async {
    final apiKey = "86bb4c18eb682dbbc50006bb75183b73df3ded0b46f12e739192a04aeda3fe22";
    final url = Uri.parse("https://api.together.xyz/v1/chat/completions");

    final headers = {
      "accept": "application/json",
      "content-type": "application/json",
      "authorization": "Bearer $apiKey"
    };

    setState(() {
      isLoading = true;
      responseText = '';
    });

    messageHistory.add({"role": "user", "content": userInput});

    final prompt = followUpCount < 2
        ? "你是一位擅長問診的醫療助理。請根據使用者症狀再問一個關鍵問題以確認需要哪一科的診所。"
        : "你是一位專業診所推薦助理，根據對話內容與使用者症狀，結合地點「$selectedCity」，請推薦合適的診所與科別，並說明原因。";

    final body = jsonEncode({
      "model": "meta-llama/Llama-3.3-70B-Instruct-Turbo-Free",
      "messages": [
        {"role": "system", "content": prompt},
        ...messageHistory.map((msg) => {
          "role": msg["role"],
          "content": msg["content"]
        })
      ],
      "temperature": 0.5,
      "max_tokens": 500
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'];
        setState(() {
          responseText = reply;
          messageHistory.add({"role": "assistant", "content": reply});
          followUpCount++;
          awaitingFollowUp = followUpCount < 3;
          isLoading = false;
        });
      } else {
        setState(() {
          responseText = textLanguage[globalLanguage.value]!['searchFailed']!;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        responseText = "${textLanguage[globalLanguage.value]!['errorOccurred']!} $e";
        isLoading = false;
      });
    }
  }

  bool isRecording = false;
  // final record = AudioRecorder();
  // final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalLanguage,
      builder: (context, selectedLanguage, _){
        return Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            backgroundColor: Colors.blue[50],
            title: Text(textLanguage[selectedLanguage]!['clinicRecommender']!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18)),
            actions: [
              PopupMenuButton<String>(
                  icon: const Icon(Icons.language),
                  onSelected: (String language){
                    globalLanguage.value = language;
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem(value: 'zh', child: Text('繁體中文')),
                    const PopupMenuItem(value: 'en', child: Text('English'))
                  ]
              ),
              // LogOut Button
              TextButton(
                onPressed: logOut,
                child: Text(textLanguage[selectedLanguage]!['logOut']!, style: TextStyle(color: Colors.black),)
              )
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.blue),
                        const SizedBox(width: 10),
                        Text(textLanguage[selectedLanguage]!['selectCity']!),
                        const Spacer(),
                        DropdownButton<String>(
                          value: selectedCity,
                          menuMaxHeight: 300,
                          underline: const SizedBox(),
                          items: cityKeys.map((key){
                            final label = textLanguage[selectedLanguage]![key]!; // 根據目前語言拿對應翻譯
                            return DropdownMenuItem<String>(
                              value: label,
                              child: Text(label),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value!;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(textLanguage[selectedLanguage]!['commonSymptoms']!, style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: symptomKeys.map((key) {
                        final label  = textLanguage[selectedLanguage]![key]!;
                        final isSelected = selectedSymptoms.contains(key);
                        return FilterChip(
                          label: Text(label),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                selectedSymptoms.add(key);
                              } else {
                                selectedSymptoms.remove(key);
                              }
                              _symptomController.text = selectedSymptoms
                                .map((k) => textLanguage[selectedLanguage]![k]!)
                                  .join(selectedLanguage == 'zh' ? '、' : ', ');
                            });
                          },
                          selectedColor: Colors.blue[200],
                          backgroundColor: Colors.blue[50],
                          checkmarkColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            TextField(
                              controller: _symptomController,
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: textLanguage[selectedLanguage]!['inputSymptoms']!,
                                border: const OutlineInputBorder(),
                                //contentPadding: const EdgeInsets.fromLTRB(12, 12, 50, 12), // 留右邊空間給按鈕
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: 45,
                                height: 45,
                                child: FloatingActionButton(
                                  onPressed: () {

                                  },
                                  backgroundColor: isRecording ? Colors.red : Colors.blue,
                                  child: const Icon(Icons.mic, size: 25, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.local_hospital),
                            label: Text(awaitingFollowUp ? textLanguage[selectedLanguage]!['submitFollowUp']! : textLanguage[selectedLanguage]!['submitFirst']!),
                            onPressed: () {
                              getRecommendation(_symptomController.text);
                              _symptomController.clear();
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (responseText.isNotEmpty)
                  Card(
                    color: Colors.blue[100],
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.medical_services, size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              responseText,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      }
    );
  }
}
