import 'package:flutter/material.dart';

class CelebrityDetail extends StatelessWidget {
  final Map<String, dynamic> celebrity;
  const CelebrityDetail({super.key, required this.celebrity});

  @override
  Widget build(BuildContext context) {
    //print(celebrity);
    return Scaffold(
      appBar: AppBar(
        title: Text(celebrity["name"]),
      ),
      body: SingleChildScrollView( // Because there are variables passed within the widget class, so cannot write const WidgetClass
        child: Column(
          children: [
            ImageSection(celebrity: celebrity,),
            DescriptionSection(celebrity: celebrity,),
          ],
        ),
      ),
    );
  }
}

// Image Class
class ImageSection extends StatelessWidget {
  final Map<String, dynamic> celebrity;
  const ImageSection({super.key, required this.celebrity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Image.asset(
        celebrity["image"], // Image
        width: 400, // Doesn't matter, as long as it exceeds the width of the original image
        height: 350,
        //fit: BoxFit.cover,
      )
    );
  }
}

// Description Class
class DescriptionSection extends StatelessWidget {
  final Map<String, dynamic> celebrity;
  const DescriptionSection({super.key, required this.celebrity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      child: Text(
        celebrity["description"],
      ),
    );
  }
}



