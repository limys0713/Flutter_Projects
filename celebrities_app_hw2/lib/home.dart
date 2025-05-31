import 'package:flutter/material.dart';
import 'package:celebrities_app_hw2/detail.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:celebrities_app_hw2/stt.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String selectedLanguage = 'en';
  List showCelebrities = [];
  final TextEditingController _searchController = TextEditingController();
  final List _celebrities = [ // Map & nested map
    {
      "name" : {
        "en": "Anne Hathaway",
        "zh": "安妮·海瑟薇"
      },
      "occupation" : {
        "en": "American actress",
        "zh": "美國女演員"
      },
      "image" : "assets/images/anne_hathaway.jpg",
      "description" : {
        "en": '''
        Anne Hathaway is an American actress known for her versatility across film genres, from romantic comedies to intense dramas. She gained early recognition for her breakout role in The Princess Diaries (2001) and later solidified her reputation with critically acclaimed performances in films like The Devil Wears Prada (2006), Les Misérables (2012), and Interstellar (2014).\n 
        Her role as Fantine in Les Misérables earned her an Academy Award for Best Supporting Actress. Known for her elegance, emotional depth, and strong screen presence, Hathaway continues to be a prominent figure in Hollywood.
        ''',
        "zh": "\u3000\u3000安妮·海瑟薇是一位美國女演員，以在各類電影類型中展現多變演技而聞名，從浪漫喜劇到深刻劇情片都有出色表現。她因2001年的《麻雀變公主》一舉成名，並在《穿著Prada的惡魔》（2006）、《悲慘世界》（2012）、《星際效應》（2014）等作品中獲得讚譽。\n\u3000\u3000她在《悲慘世界》中飾演芳汀的角色，贏得奧斯卡最佳女配角獎。憑藉她的優雅氣質、情感深度和強烈的銀幕魅力，海瑟薇持續是好萊塢的重要人物之一。",
      }
    },
    {
      "name" :  {
        "en": "Donald Trump",
        "zh": "唐納·川普"
      },
      "occupation" : {
        "en": "45th and 47th U.S. President",
        "zh": "第45任與第47任美國總統"
      },
      "image" : "assets/images/donald_trump.jpg",
      "description" : {
        "en": '''
        Donald Trump is an American businessman, television personality, and politician who served as the 45th President of the United States from 2017 to 2021. Before entering politics, he was widely known as a real estate developer and the host of the reality TV show The Apprentice. A member of the Republican Party, Trump’s presidency was marked by unconventional communication, strong nationalist rhetoric, economic reforms, and controversial immigration and foreign policy decisions.\n
        He was impeached twice by the House of Representatives but acquitted both times by the Senate. Even after leaving office, he remains a highly influential and polarizing figure in American politics.
        ''',
        "zh": "\u3000\u3000唐納·川普是一位美國商人、電視名人與政治人物，曾於2017年至2021年擔任美國第45任總統。在進入政壇之前，他因為房地產事業以及主持實境節目《誰是接班人》而廣為人知。作為共和黨成員，川普的總統任期以非傳統溝通方式、強烈民族主義言論、經濟改革及具爭議的移民與外交政策聞名。\n\u3000\u3000他曾兩度遭眾議院彈劾，但兩次均獲參議院無罪判決。即使卸任後，他依然是美國政壇極具影響力且具爭議性的人物。"
      }
    },
    {
      "name" :  {
        "en": "Elon Musk",
        "zh": "伊隆·馬斯克"
      },
      "occupation" : {
        "en": "Entrepreneur",
        "zh": "企業家"
      },
      "image" : "assets/images/elon_musk.jpg",
      "description" : {
        "en": '''
        Elon Musk is a billionaire entrepreneur, inventor, and engineer known for founding and leading several groundbreaking technology companies. He is the CEO and lead designer of SpaceX, CEO and product architect of Tesla, Inc., and owner and CTO of X (formerly Twitter). Musk also co-founded Neuralink, The Boring Company, and was an early force behind PayPal.\n 
        Born in South Africa in 1971, Musk is known for his ambitious vision to revolutionize space travel, electric vehicles, artificial intelligence, and brain-computer interfaces. His bold ideas, controversial statements, and disruptive business strategies have made him one of the most influential—and polarizing—figures in modern technology and business.
        ''',
        "zh": "\u3000\u3000伊隆·馬斯克是一位億萬富翁企業家、發明家與工程師，創辦並領導多家顛覆性科技公司。他是SpaceX的執行長與首席設計師、Tesla的執行長與產品架構師，以及X（前Twitter）的所有者與技術總監。他還共同創辦了Neuralink、The Boring Company，並早期參與PayPal的發展。\n\u3000\u3000馬斯克於1971年出生於南非，以其顛覆太空旅行、電動車、人工智慧與腦機介面的遠大願景而聞名。他大膽的想法、爭議性的言論與破壞式的商業策略，使他成為當代科技與商業界最具影響力與爭議性的人物之一。"
      }
    },
    {
      "name" :  {
        "en": "Go Youn-jung",
        "zh": "高允貞"
      },
      "occupation" : {
        "en": "South Korean actress",
        "zh": "韓國女演員"
      },
      "image" : "assets/images/go_youn_jung.jpg",
      "description" : {
        "en": '''
        Go Youn-jung is a South Korean actress and model known for her beauty, charisma, and rising presence in Korean dramas. She began her career as a model before transitioning into acting, gaining attention with supporting roles in He Is Psychometric (2019) and Sweet Home (2020).\n
        Her breakout performance came in Alchemy of Souls: Light and Shadow (2022–2023), where she took on the lead role and impressed audiences with her emotional depth and action skills. With a growing fan base and increasing critical acclaim, Go Youn-jung is quickly becoming one of the most promising young actresses in the Korean entertainment industry.
        ''',
        "zh": "\u3000\u3000高允貞是韓國女演員兼模特兒，以其美貌、魅力及在韓劇中的上升人氣而知名。她以模特兒出道，後來轉向演員職涯，在《會讀心術的那小子》（2019）與《Sweet Home》（2020）中擔任配角受到關注。\n\u3000\u3000她在《還魂：光與影》（2022–2023）中擔綱主角，憑藉情感張力與動作戲表現獲得好評。隨著人氣上升與評論肯定，高允貞快速成為韓國娛樂圈中最具潛力的新生代演員之一。"
      }
    },
    {
      "name" :  {
        "en": "Han So-hee",
        "zh": "韓素希"
      },
      "occupation" : {
        "en": "South Korean actress",
        "zh": "韓國女演員"
      },
      "image" : "assets/images/han_so_hee.jpg",
      "description" : {
        "en": '''
        Han So Hee is a South Korean actress and model known for her striking visuals and emotionally intense performances. She gained widespread recognition for her breakout role as the mistress in the hit drama The World of the Married (2020), which became one of the highest-rated Korean cable series of all time.\n
        Following that, she solidified her star status with leading roles in Nevertheless (2021), My Name (2021), and Gyeongseong Creature (2023). Known for her versatility and bold role choices, Han So Hee has quickly become one of the most sought-after actresses in Korean entertainment.
        ''',
        "zh": "\u3000\u3000韓素希是韓國演員與模特兒，以亮眼外貌與深刻演技聞名。她憑藉《夫婦的世界》（2020）中小三一角爆紅，該劇成為韓國有線電視史上收視最高劇集之一。\n\u3000\u3000此後，她透過主演《無法抗拒的他》（2021）、《以吾之名》（2021）、《京城怪物》（2023）進一步鞏固人氣。她因多樣化的演技與勇敢的角色選擇而深受矚目，迅速成為韓國娛樂圈最受追捧的女演員之一。"
      }
    },
    {
      "name" :  {
        "en": "Kim Ji-won",
        "zh": "金智媛"
      },
      "occupation" : {
        "en": "South Korean actress",
        "zh": "韓國女演員"
      },
      "image" : "assets/images/kim_ji_won.jpg",
      "description" : {
        "en": '''
        Kim Ji-won is a South Korean actress known for her strong screen presence and versatile acting across romance, drama, and action genres. She rose to fame with her role as the chic army doctor in the massively popular drama Descendants of the Sun (2016).\n
        She further established her status with standout performances in Fight for My Way (2017), Arthdal Chronicles (2019), and My Liberation Notes (2022), where her portrayal of a quiet, introspective woman seeking freedom earned widespread critical praise. With her natural charm and emotional depth, Kim Ji-won is regarded as one of the leading actresses of her generation in Korean television.
        ''',
        "zh": "\u3000\u3000金智媛是韓國女演員，以強烈的螢幕存在感和跨越愛情、劇情與動作類型的多樣演技著稱。她在《太陽的後裔》（2016）中飾演帥氣軍醫一角而走紅。\n\u3000\u3000她隨後在《三流之路》（2017）、《阿斯達年代記》（2019）、《我的出走日記》（2022）中的精彩演出，特別是後者中飾演渴望自由的內向女子，獲得廣泛好評。憑藉自然的魅力與深厚情感表達，金智媛被視為韓國電視界同代演員中的佼佼者。"
      }
    },
    {
      "name" :  {
        "en": "Lily Collins",
        "zh": "莉莉·柯林斯"
      },
      "occupation" : {
        "en": "American actress",
        "zh": "美國女演員"
      },
      "image" : "assets/images/lily_collins.jpg",
      "description" : {
        "en": '''
        Lily Collins is a British-American actress, model, and author, known for her charm, elegance, and diverse acting roles. She began her career in television and film with early roles in The Blind Side (2009) and Mirror Mirror (2012), where she played Snow White. Her breakout performance came with the critically praised film To the Bone (2017), where she portrayed a young woman battling an eating disorder.\n
        She gained international fame starring as Emily Cooper in the hit Netflix series Emily in Paris (2020–present). The daughter of musician Phil Collins, Lily has also written a memoir, Unfiltered, sharing her personal struggles and growth.
        ''',
        "zh": "\u3000\u3000莉莉·柯林斯是英美混血的演員、模特與作家，以其優雅氣質與多樣化的演技風格著稱。她於《弱點》（2009）與《魔鏡魔鏡》（2012）中飾演白雪公主開啟演藝生涯。\n\u3000\u3000她在《骷髏少女》（2017）中的表現大獲好評，飾演一位與飲食障礙奮戰的年輕女性。她因主演Netflix熱門影集《艾蜜莉在巴黎》（2020至今）而在全球走紅。莉莉是音樂家菲爾·柯林斯的女兒，也曾出版回憶錄《不加濾鏡》，分享自己的掙扎與成長。"
      }
    },
    {
      "name" :  {
        "en": "Michael Jordan",
        "zh": "麥可·喬丹"
      },
      "occupation" : {
        "en": "Former American Basketball Player",
        "zh": "前美國籃球員"
      },
      "image" : "assets/images/jordan.jpg",
      "description" : {
        "en": '''
        Michael Jordan is a legendary American basketball player, widely considered the greatest of all time. Born on February 17, 1963, he played 15 seasons in the NBA, primarily with the Chicago Bulls, where he led the team to six championships and earned five MVP awards. Known for his unmatched competitiveness, athleticism, and clutch performances, he became a global icon both on and off the court.\n 
        Beyond basketball, Jordan built a business empire through endorsements—most notably with Nike’s Air Jordan brand—and served as the principal owner of the Charlotte Hornets. His legacy continues to inspire athletes and fans around the world.
        ''',
        "zh": "\u3000\u3000麥可·喬丹是傳奇性的美國籃球員，被廣泛認為是史上最偉大的球員。他於1963年2月17日出生，在NBA效力15個賽季，主要為芝加哥公牛隊，帶領球隊奪得六次總冠軍並五度獲得MVP。\n\u3000\u3000以無與倫比的競爭力、運動能力與關鍵時刻的表現著稱，他在場內外都成為全球偶像。除了籃球之外，喬丹透過代言建立起龐大的商業帝國，最知名的是與Nike合作的Air Jordan品牌，並成為夏洛特黃蜂隊的主要股東。他的傳奇至今仍激勵無數運動員與球迷。"
      }
    },
    {
      "name" :  {
        "en": "Stephen Curry",
        "zh": "史蒂芬·柯瑞"
      },
      "occupation" : {
        "en": "American Basketball Player",
        "zh": "美國籃球員"
      },
      "image" : "assets/images/stephen_curry.jpg",
      "description" : {
        "en": '''
        Stephen Curry is an American professional basketball player widely regarded as the greatest shooter in NBA history. Playing as a point guard for the Golden State Warriors, he revolutionized the game with his deep three-point shooting and fast-paced playstyle.\n 
        Born on March 14, 1988, Curry led the Warriors to multiple NBA championships (2015, 2017, 2018, 2022) and won two MVP awards, including the first-ever unanimous MVP in 2016. Known for his leadership, skill, and humility, Curry has had a transformative impact on modern basketball and remains one of the sport’s most influential and beloved figures.
        ''',
        "zh": "\u3000\u3000史蒂芬·柯瑞是美國職業籃球員，被廣泛視為NBA史上最偉大的射手。他是金州勇士隊的控球後衛，以遠距離三分球與快速節奏的打法徹底改變了比賽風格。\n\u3000\u3000柯瑞於1988年3月14日出生，曾帶領勇士隊奪得多次NBA總冠軍（2015、2017、2018、2022），並贏得兩次MVP，其中包括史上首次全票MVP（2016）。他以領導力、技巧與謙遜著稱，對現代籃球產生深遠影響，是當今最受歡迎與敬重的運動員之一。"
      }
    },
    {
      "name" :  {
        "en": "Winter",
        "zh": "Winter（金旼炡）"
      },
      "occupation" : {
        "en": "South Korean singer and dancer",
        "zh": "韓國歌手與舞者"
      },
      "image" : "assets/images/winter.jpg",
      "description" : {
        "en": '''
        Winter, born Kim Min-jeong on January 1, 2001, is a South Korean singer, dancer, and a member of the K-pop girl group aespa, under SM Entertainment. She debuted with the group in 2020 with the hit single Black Mamba and quickly gained popularity for her powerful vocals, sharp dance skills, and cool, charismatic visuals.\n
        Known for her stage presence and versatility, Winter is a standout performer in aespa's futuristic and high-concept music style. As part of the group’s global rise, she has contributed to hits like Next Level, Savage, and Spicy, making her one of the prominent fourth-generation K-pop idols.
        ''',
        "zh": "\u3000\u3000Winter，本名金旼炡，2001年1月1日出生，是韓國歌手與舞者，隸屬於SM娛樂旗下K-pop女團aespa成員。她於2020年以熱門單曲《Black Mamba》出道，迅速以強勁歌聲、俐落舞技與冷酷魅力吸引關注。\n\u3000\u3000她以強大的舞台表現與多變風格聞名，是aespa未來派高概念音樂風格中的亮眼成員。作為團體全球人氣上升的一部分，她參與的《Next Level》、《Savage》、《Spicy》等歌曲也廣受歡迎，是第四代K-pop偶像中的代表人物之一。"
      }
    },
  ];

  // Initialization
  // Get the name of all celebrities
  @override
  void initState(){
    super.initState();
    showCelebrities = List.from(_celebrities);
  }

  // Release memory
  // Search Controller and then parent
  @override
  void dispose(){
    _searchController.dispose();
    super.dispose();
  }

  void _searchCelebrities(String keyword){
    setState(() {
      showCelebrities = _celebrities.where((celebrity) => celebrity["name"][selectedLanguage].contains(keyword) || celebrity["occupation"][selectedLanguage].contains(keyword)).toList();
    });
  }

  bool isRecording = false;
  final record = AudioRecorder();
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celebrities'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String language){
              setState(() {
                selectedLanguage = language;
              });
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'en', child: Text('English')),
              const PopupMenuItem(value: 'zh', child: Text('中文')),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: Column(
        children: [
          // The Recording Button & Search Bar
          Row(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: 40,
                height: 40,
                child: FloatingActionButton.extended(
                  onPressed: () async {
                    final tempPath = await getTemporaryDirectory();
                    String path = "${tempPath.path}/audio.wav";
                    if(isRecording){
                      // Stop recording
                      await record.stop();
                      // Request function in stt.dart
                      String? result = await request(path);
                      //print(result);
                        if(result != null){
                          _searchController.text = result;
                        }else{
                          _searchController.text = "";
                        }

                      isRecording = false;
                    }else{
                      // Start recording
                      if(await record.hasPermission()){
                        await record.start(
                          const RecordConfig(
                            sampleRate: 16000,
                            numChannels: 1,
                            encoder: AudioEncoder.wav,
                          ),
                        path: path
                        );
                      }
                      isRecording = true;
                    }
                    setState(() {});
                  },
                  label: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 20,
                  ),
                  backgroundColor: isRecording ? Colors.red : Colors.blue,
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                )
              ),
              IconButton(
                  onPressed: () => _searchCelebrities(_searchController.text),
                  icon: Icon(Icons.search),
              ),
            ],
          ),
          // The Celebrities Card
          Expanded(
            child: ListView.builder(
              /* ListView.builder:
              Flutter only builds the tiles that are currently visible on screen, like maybe the first 10.
              As you scroll, it destroys old ones and creates new ones dynamically.
              This is called lazy loading or virtual scrolling.
              */
              itemCount: showCelebrities.length,
              itemBuilder: (context, index){
                return Card(
                  // Outer Space from the card
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  // Shadow level
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    // Circular edge
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      showCelebrities[index]["image"],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(showCelebrities[index]["name"][selectedLanguage]),
                    subtitle: Text(showCelebrities[index]["occupation"][selectedLanguage]),
                    // trailing: On the right side >> leading: On the left side
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return CelebrityDetail(
                              celebrity: showCelebrities[index],
                              language: selectedLanguage,
                            );
                          })
                        ); //Navigator.push()
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  )
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
