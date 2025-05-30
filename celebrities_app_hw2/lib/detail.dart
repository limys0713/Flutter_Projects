import 'package:flutter/material.dart';
import 'package:celebrities_app_hw2/tts.dart';
import 'package:just_audio/just_audio.dart';

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
            FloatingButtonSection(celebrity: celebrity),
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
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      child: Text(
        celebrity["description"],
      ),
    );
  }
}

// Floating Button Widget Class
class FloatingButtonSection extends StatelessWidget {
  final Map<String, dynamic> celebrity;
  const FloatingButtonSection({super.key, required this.celebrity});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () async{ // It tells dart it will use await in the function : asynchronous action is needed
        // // Trim and simplify before send the text
        // String fullText = celebrity["description"]
        //     .replaceAll('\n', ' ')     // Remove newlines
        //     .replaceAll(RegExp(r'\s+'), ' ') // Remove double spaces
        //     .trim();                   // Remove leading/trailing whitespace
        // // Split the text
        // List<String> chunks = fullText
        //     .split('.')         // Split by period
        //     .map((s) => s.trim())   // Remove space around each sentence
        //     .where((s) => s.isNotEmpty) //Discard empty sentence
        //     .toList();      // Convert to List<String>
        //
        // final player = AudioPlayer();
        // for(int i = 0; i < chunks.length; i+=1){
        //   // Combine 2 sentences, send 2 sentences to server at a time
        //   String combined = chunks.skip(i).take(1).join('.');
        //
        //   print("Sending: $combined");
        //
        //   String? path = await processAudioFile(combined);
        //   if(path != null){
        //     await player.setFilePath(path);
        //     await player.play();
        //     // Wait for the duration of the audio file to finish playing, unless the duration is null
        //     Duration duration = await player.durationStream
        //         .firstWhere((d) => d != null) as Duration;
        //     await Future.delayed(duration);
        //
        //     // Add delay between sentences (0.5 seconds)
        //     await Future.delayed(Duration(milliseconds: 500));
        //   }else{
        //     print("Failed to load: $combined");
        //     break;
        //   }
        // }

        String? path = await processAudioFile("Testing");
        if(path != null){
          final player = AudioPlayer();
          await player.setFilePath(path); // Set local file
          await player.play();  // Start playing
        }else{
          print("Failed to generate or load audio!");
        }
      },
      child: Icon(Icons.play_arrow),
    );
  }
}


