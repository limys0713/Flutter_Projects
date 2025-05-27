import 'package:flutter/material.dart';
import 'package:celebrities_app_hw2/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List showCelebrities = [];
  final TextEditingController _searchController = TextEditingController();
  final List _celebrities = [
    {
      "name" :  "Anne Hathaway",
      "occupation" : "American actress",
      "image" : "assets/images/anne_hathaway.jpg",
      "description" :
        '''
        Anne Hathaway is an American actress known for her versatility across film genres, from romantic comedies to intense dramas. She gained early recognition for her breakout role in The Princess Diaries (2001) and later solidified her reputation with critically acclaimed performances in films like The Devil Wears Prada (2006), Les Misérables (2012), and Interstellar (2014).\n 
        Her role as Fantine in Les Misérables earned her an Academy Award for Best Supporting Actress. Known for her elegance, emotional depth, and strong screen presence, Hathaway continues to be a prominent figure in Hollywood.
        '''
    },
    {
      "name" :  "Donald Trump",
      "occupation" : "45th and 47th U.S. President",
      "image" : "assets/images/donald_trump.jpg",
      "description" :
        '''
        Donald Trump is an American businessman, television personality, and politician who served as the 45th President of the United States from 2017 to 2021. Before entering politics, he was widely known as a real estate developer and the host of the reality TV show The Apprentice. A member of the Republican Party, Trump’s presidency was marked by unconventional communication, strong nationalist rhetoric, economic reforms, and controversial immigration and foreign policy decisions.\n
        He was impeached twice by the House of Representatives but acquitted both times by the Senate. Even after leaving office, he remains a highly influential and polarizing figure in American politics.
        '''
    },
    {
      "name" :  "Elon Musk",
      "occupation" : "Entrepreneur",
      "image" : "assets/images/elon_musk.jpg",
      "description" :
        '''
        Elon Musk is a billionaire entrepreneur, inventor, and engineer known for founding and leading several groundbreaking technology companies. He is the CEO and lead designer of SpaceX, CEO and product architect of Tesla, Inc., and owner and CTO of X (formerly Twitter). Musk also co-founded Neuralink, The Boring Company, and was an early force behind PayPal.\n 
        Born in South Africa in 1971, Musk is known for his ambitious vision to revolutionize space travel, electric vehicles, artificial intelligence, and brain-computer interfaces. His bold ideas, controversial statements, and disruptive business strategies have made him one of the most influential—and polarizing—figures in modern technology and business.
        '''
    },
    {
      "name" :  "Go Youn-jung",
      "occupation" : "South Korean actress",
      "image" : "assets/images/go_youn_jung.jpg",
      "description" :
        '''
        Go Youn-jung is a South Korean actress and model known for her beauty, charisma, and rising presence in Korean dramas. She began her career as a model before transitioning into acting, gaining attention with supporting roles in He Is Psychometric (2019) and Sweet Home (2020).\n
        Her breakout performance came in Alchemy of Souls: Light and Shadow (2022–2023), where she took on the lead role and impressed audiences with her emotional depth and action skills. With a growing fan base and increasing critical acclaim, Go Youn-jung is quickly becoming one of the most promising young actresses in the Korean entertainment industry.
        '''
    },
    {
      "name" :  "Han So-hee",
      "occupation" : "South Korean actress",
      "image" : "assets/images/han_so_hee.jpg",
      "description" :
        '''
        Han So Hee is a South Korean actress and model known for her striking visuals and emotionally intense performances. She gained widespread recognition for her breakout role as the mistress in the hit drama The World of the Married (2020), which became one of the highest-rated Korean cable series of all time.\n
        Following that, she solidified her star status with leading roles in Nevertheless (2021), My Name (2021), and Gyeongseong Creature (2023). Known for her versatility and bold role choices, Han So Hee has quickly become one of the most sought-after actresses in Korean entertainment.
        '''
    },
    {
      "name" :  "Kim Ji-won",
      "occupation" : "South Korean actress",
      "image" : "assets/images/kim_ji_won.jpg",
      "description" :
        '''
        Kim Ji-won is a South Korean actress known for her strong screen presence and versatile acting across romance, drama, and action genres. She rose to fame with her role as the chic army doctor in the massively popular drama Descendants of the Sun (2016).\n
        She further established her status with standout performances in Fight for My Way (2017), Arthdal Chronicles (2019), and My Liberation Notes (2022), where her portrayal of a quiet, introspective woman seeking freedom earned widespread critical praise. With her natural charm and emotional depth, Kim Ji-won is regarded as one of the leading actresses of her generation in Korean television.
        '''
    },
    {
      "name" :  "Lily Collins",
      "occupation" : "American actress",
      "image" : "assets/images/lily_collins.jpg",
      "description" :
        '''
        Lily Collins is a British-American actress, model, and author, known for her charm, elegance, and diverse acting roles. She began her career in television and film with early roles in The Blind Side (2009) and Mirror Mirror (2012), where she played Snow White. Her breakout performance came with the critically praised film To the Bone (2017), where she portrayed a young woman battling an eating disorder.\n
        She gained international fame starring as Emily Cooper in the hit Netflix series Emily in Paris (2020–present). The daughter of musician Phil Collins, Lily has also written a memoir, Unfiltered, sharing her personal struggles and growth.
        '''
    },
    {
      "name" :  "Michael Jordan",
      "occupation" : "Former American Basketball Player",
      "image" : "assets/images/jordan.jpg",
      "description" :
        '''
        Michael Jordan is a legendary American basketball player, widely considered the greatest of all time. Born on February 17, 1963, he played 15 seasons in the NBA, primarily with the Chicago Bulls, where he led the team to six championships and earned five MVP awards. Known for his unmatched competitiveness, athleticism, and clutch performances, he became a global icon both on and off the court.\n 
        Beyond basketball, Jordan built a business empire through endorsements—most notably with Nike’s Air Jordan brand—and served as the principal owner of the Charlotte Hornets. His legacy continues to inspire athletes and fans around the world.
        '''
    },
    {
      "name" :  "Stephen Curry",
      "occupation" : "American Basketball Player",
      "image" : "assets/images/stephen_curry.jpg",
      "description" :
        '''
        Stephen Curry is an American professional basketball player widely regarded as the greatest shooter in NBA history. Playing as a point guard for the Golden State Warriors, he revolutionized the game with his deep three-point shooting and fast-paced playstyle.\n 
        Born on March 14, 1988, Curry led the Warriors to multiple NBA championships (2015, 2017, 2018, 2022) and won two MVP awards, including the first-ever unanimous MVP in 2016. Known for his leadership, skill, and humility, Curry has had a transformative impact on modern basketball and remains one of the sport’s most influential and beloved figures.
        '''
    },
    {
      "name" :  "Winter",
      "occupation" : "South Korean singer and dancer",
      "image" : "assets/images/winter.jpg",
      "description" :
        '''
        Winter, born Kim Min-jeong on January 1, 2001, is a South Korean singer, dancer, and a member of the K-pop girl group aespa, under SM Entertainment. She debuted with the group in 2020 with the hit single Black Mamba and quickly gained popularity for her powerful vocals, sharp dance skills, and cool, charismatic visuals.\n
        Known for her stage presence and versatility, Winter is a standout performer in aespa's futuristic and high-concept music style. As part of the group’s global rise, she has contributed to hits like Next Level, Savage, and Spicy, making her one of the prominent fourth-generation K-pop idols.
        '''
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
      showCelebrities = _celebrities.where((celebrity) => celebrity["name"].contains(keyword) || celebrity["occupation"].contains(keyword)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Celebrities'),
      ),
      body: Column(
        children: [
          // The Search Bar
          Row(
            children: [
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
                    title: Text(showCelebrities[index]["name"]),
                    subtitle: Text(showCelebrities[index]["occupation"]),
                    // trailing: On the right side >> leading: On the left side
                    trailing: IconButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return CelebrityDetail(celebrity: showCelebrities[index]);
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
