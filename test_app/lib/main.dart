// ─────────────────────────────────────────────────────────────────────────────
//  Flutter Layout Demo - Annotated Version
//  ---------------------------------------------------------------------------
//  本範例示範如何利用 Material 風格的 Scaffold 佈局出一個可捲動的度假村資訊頁。
//  每個區塊都附上說明，方便您快速理解 widget 的責任與常用屬性。
// ─────────────────────────────────────────────────────────────────────────────

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// 1. 程式進入點
//    • 使用箭頭函式 (=>) 直接回傳 runApp，語法更簡潔。
//    • 也可以寫成 void main(){return runApp(const MyApp());}
//    • runApp() 會把整棵 Widget 樹插入原生視窗並啟動 Flutter app。
// ─────────────────────────────────────────────────────────────────────────────
void main() => runApp(const MyApp());

// ─────────────────────────────────────────────────────────────────────────────
// 2. MyApp – 最外層 Widget
//    StatelessWidget 表示自身不保存可變狀態，畫面僅由輸入決定。
// ─────────────────────────────────────────────────────────────────────────────

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // ↑ key: Flutter 用來唯一標識一個 widget，在重新 build 時可憑 Key 判斷「這還是同一顆 widget 嗎？」從而保住狀態或做動畫對應。
  // ↑ super.key: 直接把名為 key 的參數 宣告並轉傳 給父類別建構子（這裡父類別是 StatelessWidget 或 StatefulWidget）。
  @override
  Widget build(BuildContext context) {
    // ↑ BuildContext: Flutter 用來在 Widget 樹中向上查詢父層資料（主題、路由等）。

    const String appTitle = 'hw1';

    return MaterialApp(
      // title 僅顯示於 Android Task Switcher 與 Web <title> 標籤。
      title: appTitle,

      // ThemeData 控制全域色彩、字型、元件樣式。
      //theme: ThemeData(primarySwatch: Colors.teal),

      // Scaffold 提供預設的 Material 結構：AppBar、Drawer、FAB… 等。
      home: Scaffold(
        // ─ AppBar: 置頂工具列 ─
        appBar: AppBar(title: const Text(appTitle)),

        // ─ Body: 以 SingleChildScrollView 包裹 Column，避免窄螢幕 overflow ─
        /*
         SingleChidScrollView: Scrollable container that allows one child widget to scroll vertically or horizontally
         if it overflows the screen
         */
        body: const SingleChildScrollView(
          child: Column(
            children: [
              TitleSection(
                // 標題 + 地點 + 愛心計數器
                name: 'Tioman Island',
                location: 'Pahang, Malaysia',
              ),
              ImageSection(), // Banner 圖
              ButtonSection(), // 三顆功能按鈕
              TextSection(), // 詳細描述
            ],
          ),
        ),
        // Cuz it is a property of Scaffold class
        floatingActionButton: const FloatingButtonSection(),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. ImageSection – 最上方橫幅圖片
//    Image.asset 讀取在 pubspec.yaml 登記的本地圖片資源。
// ─────────────────────────────────────────────────────────────────────────────
class ImageSection extends StatelessWidget {
  const ImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      //Image widget
      'assets/images/tioman_island.jpg', // 圖片路徑
      width: 600, // 版心寬度提示；實際尺寸受父層限制
      height: 240,
      fit: BoxFit.cover, // 依比例放大填滿，超出部分裁切
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. TitleSection – 名稱、地點與收藏數
//    透過 Expanded 把文字擠在左側，右側顯示愛心 icon 與計數。
// ─────────────────────────────────────────────────────────────────────────────
class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.name, required this.location});
  //TitleSection(name: 'Sunny Beach Resort',location: 'California, USA',)
  final String name;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Padding(
      //給子 widget 四周留一圈指定寬度的「內邊距 (padding)」
      padding: const EdgeInsets.all(32),
      //邊距為32
      child: Row(
        children: [
          // Expanded 佔據剩餘水平空間，讓後方圖示靠右。
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    name,
                    style: const TextStyle(
                      //fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 40
                    ),
                  ),
                ),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20
                  ),
                ),
              ],
            ),
          ),
          // 右側收藏
          //Icon(Icons.favorite, color: Colors.red[600]),
          //const SizedBox(width: 4), // Gap
          //const Text('99'),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. ButtonSection – CALL / ROUTE / SHARE 三顆按鈕
//    取用主題色以保持一致視覺。
// ─────────────────────────────────────────────────────────────────────────────
class ButtonSection extends StatelessWidget {
  const ButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.only(top: 32.0, bottom: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Not a button widget, just a text widget
          ButtonWithText(
              color: color,
              icon: Icons.thumb_up,
              label: 'LIKE'
          ),
          ButtonWithText(
              color: color,
              icon: Icons.location_on,
              label: 'LOCATION'
          ),
          ButtonWithText(
              color: color,
              icon: Icons.info,
              label: 'DETAIL'
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 5-1. ButtonWithText – 可重複使用的小元件
// ─────────────────────────────────────────────────────────────────────────────
class ButtonWithText extends StatelessWidget {
  const ButtonWithText({
    super.key,
    required this.color,
    required this.icon,
    required this.label,
  });

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color effectiveColor = color;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: effectiveColor),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: effectiveColor
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. TextSection – 底部說明文字
//    若內容冗長，可改 SelectableText 或加入 "閱讀更多" 收合動畫。
// ─────────────────────────────────────────────────────────────────────────────
class TextSection extends StatelessWidget {
  const TextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Text(
        '''
        Tioman Island is one of Malaysia's most beautiful and well-known tropical islands, famous for its crystal-clear waters, lush rainforests, and vibrant coral reefs.
        It has been listed as one of the world’s most beautiful islands by Time Magazine in the 1970s.
        ''',
        softWrap: true, // It will automatically change to next line if it reaches the screen edge
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}


/*
  FloatingActionButton is a property of Scaffold, so put within widget class Scaffold
 */
class FloatingButtonSection extends StatelessWidget {
  const FloatingButtonSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: (){
        //print('Floating Button clicked!');
      },
      child: const Icon(Icons.add),
    );
  }
}

