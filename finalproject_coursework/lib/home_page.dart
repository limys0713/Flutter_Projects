//Version4 - 加入搜尋中動畫提示
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:finalproject_coursework/language_mapping.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCity = '台北市';
  final TextEditingController _symptomController = TextEditingController();
  String responseText = '';
  bool awaitingFollowUp = false;
  int followUpCount = 0;
  List<Map<String, String>> messageHistory = [];
  bool isLoading = false;

  final List<String> commonSymptoms = [
    '發燒', '咳嗽', '喉嚨痛', '頭痛', '流鼻水',
    '嘔吐', '腹瀉', '胸悶', '肌肉痠痛', '全身無力'
  ];
  Set<String> selectedSymptoms = {};

  @override
  void dispose(){
    _symptomController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: globalLanguage,
      builder: (context, selectedLanguage, _){
        return Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            backgroundColor: Colors.blue[50],
            title: Text(textLanguage[selectedLanguage]!['clinicRecommender']!, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
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
                          underline: const SizedBox(),
                          items: [
                            //先訂六都 之後全部弄好再全加進去
                            '台北市', '新北市', '桃園市', '台中市', '台南市', '高雄市'
                          ].map((city) => DropdownMenuItem(
                            value: city,
                            child: Text(city),
                          )).toList(),
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
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: commonSymptoms.map((symptom) {
                    final isSelected = selectedSymptoms.contains(symptom);
                    return FilterChip(
                      label: Text(symptom),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        setState(() {
                          if (selected) {
                            selectedSymptoms.add(symptom);
                          } else {
                            selectedSymptoms.remove(symptom);
                          }
                          _symptomController.text = selectedSymptoms.join('、');
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
                const SizedBox(height: 20),
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _symptomController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            labelText: textLanguage[selectedLanguage]!['inputSymptoms']!,
                            border: OutlineInputBorder(),
                          ),
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
