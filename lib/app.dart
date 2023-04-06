import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:provider/provider.dart';
import 'model_theme.dart';

class SpeakIt extends StatefulWidget {
  const SpeakIt({Key? key}) : super(key: key);

  @override
  State<SpeakIt> createState() => _SpeakItState();
}

class _SpeakItState extends State<SpeakIt> {
  final TextToSpeech _textToSpeech = TextToSpeech();
  final TextEditingController _textEditingController = TextEditingController();
  double _volume = 0.5;
  double _rate = 0.7;
  double _pitch = 1;

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        backgroundColor: themeNotifier.isDark
            ? null
            : const Color.fromRGBO(227, 204, 174, 1),
        //rgb(227, 204, 174)
        appBar: AppBar(
            backgroundColor: const Color.fromRGBO(184, 98, 27, 1),
            //rgb(184, 98, 27)
            title: Text(
              'Speak It App',
              style: GoogleFonts.aBeeZee(
                  fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(themeNotifier.isDark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny),
              onPressed: () {
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
              },
            )),
        body: Container(
          // color: Colors.green,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: TextField(
                  style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: themeNotifier.isDark
                          ? const Color.fromRGBO(227, 204, 174, 1)
                          : const Color.fromRGBO(38, 42, 86, 1)),
                  cursorColor: const Color.fromRGBO(184, 98, 27, 1),
                  maxLines: 7,
                  decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(184, 98, 27, 1), width: 2.0),
                      ),
                      border: const OutlineInputBorder(),
                      hintText: 'Enter your text here..',
                      hintStyle: GoogleFonts.aBeeZee()),
                  controller: _textEditingController,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    "Volume",
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeNotifier.isDark
                            ? const Color.fromRGBO(227, 204, 174, 1)
                            : const Color.fromRGBO(38, 42, 86, 1)),
                  ),
                  Expanded(
                    child: Slider(
                        inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
                        activeColor: const Color.fromRGBO(184, 98, 27, 1),
                        max: 1,
                        value: _volume,
                        onChanged: (newVal) {
                          setState(() {
                            _volume = newVal;
                          });
                        }),
                  ),
                  Text(
                    _volume.toStringAsFixed(2),
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeNotifier.isDark
                            ? const Color.fromRGBO(227, 204, 174, 1)
                            : const Color.fromRGBO(38, 42, 86, 1)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Rate",
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeNotifier.isDark
                            ? const Color.fromRGBO(227, 204, 174, 1)
                            : const Color.fromRGBO(38, 42, 86, 1)),
                  ),
                  Expanded(
                    child: Slider(
                        inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
                        activeColor: const Color.fromRGBO(184, 98, 27, 1),
                        max: 2,
                        value: _rate,
                        onChanged: (newVal) {
                          setState(() {
                            _rate = newVal;
                          });
                        }),
                  ),
                  Text(
                    _rate.toStringAsFixed(2),
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeNotifier.isDark
                            ? const Color.fromRGBO(227, 204, 174, 1)
                            : const Color.fromRGBO(38, 42, 86, 1)),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "Pitch",
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeNotifier.isDark
                            ? const Color.fromRGBO(227, 204, 174, 1)
                            : const Color.fromRGBO(38, 42, 86, 1)),
                  ),
                  Expanded(
                    child: Slider(
                        inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
                        activeColor: const Color.fromRGBO(184, 98, 27, 1),
                        max: 2,
                        value: _pitch,
                        onChanged: (newVal) {
                          setState(() {
                            _pitch = newVal;
                          });
                        }),
                  ),
                  Text(
                    _pitch.toStringAsFixed(2),
                    style: GoogleFonts.aBeeZee(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: themeNotifier.isDark
                            ? const Color.fromRGBO(227, 204, 174, 1)
                            : const Color.fromRGBO(38, 42, 86, 1)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildElevatedButton(
                      themeNotifier: themeNotifier,
                      onPressed: () async {
                        await _textToSpeech.setVolume(_volume);
                        await _textToSpeech.setRate(_rate);
                        await _textToSpeech.setPitch(_pitch);
                        await _textToSpeech.speak(_textEditingController.text);
                      },
                      buttonText: 'Speak'),
                  const SizedBox(width: 20),
                  buildElevatedButton(
                      themeNotifier: themeNotifier,
                      onPressed: () async {
                        await _textToSpeech.stop();
                      },
                      buttonText: 'Stop'),
                  const SizedBox(width: 20),
                  buildElevatedButton(
                      themeNotifier: themeNotifier,
                      onPressed: () {
                        setState(() {
                          _volume = 0.5;
                          _rate = 0.7;
                          _pitch = 1;
                        });
                      },
                      buttonText: 'Set Default'),
                ],
              )
            ],
          ),
        ),
      );
    });
  }


  //Slider Row Widget
/*
  Widget biuldSliderRow({
    required ModelTheme themeNotifier,
    required String rowTitle,
    required double maxSliderVal,
    required double sliderVal,
  }) {
    return Row(
      children: [
        Text(
          rowTitle,
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: themeNotifier.isDark
                  ? const Color.fromRGBO(227, 204, 174, 1)
                  : const Color.fromRGBO(38, 42, 86, 1)),
        ),
        Expanded(
          child: Slider(
              inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
              activeColor: const Color.fromRGBO(184, 98, 27, 1),
              max: maxSliderVal,
              value: sliderVal,
              onChanged: (newVal) {
                setState(() {
                  sliderVal = newVal;
                });
              }),
        ),
        Text(
          sliderVal.toStringAsFixed(2),
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: themeNotifier.isDark
                  ? const Color.fromRGBO(227, 204, 174, 1)
                  : const Color.fromRGBO(38, 42, 86, 1)),
        ),
      ],
    );
  }

 */

  Widget buildElevatedButton(
      {required ModelTheme themeNotifier,
      required VoidCallback onPressed,
      required String buttonText}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: themeNotifier.isDark
              ? const Color.fromRGBO(227, 204, 174, 1)
              : const Color.fromRGBO(38, 42, 86, 1)),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: themeNotifier.isDark
                ? const Color.fromRGBO(124, 61, 11, 1.0)
                : const Color.fromRGBO(227, 204, 174, 1)),
      ),
    );
  }
}
