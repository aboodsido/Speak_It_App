import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translator/translator.dart';
import 'package:text_to_speech/text_to_speech.dart';
import 'package:provider/provider.dart';
import 'model_theme.dart';

class SpeakIt extends StatefulWidget {
  const SpeakIt({Key? key}) : super(key: key);

  @override
  State<SpeakIt> createState() => _SpeakItState();
}

class _SpeakItState extends State<SpeakIt> {
  final _textToSpeech = TextToSpeech();
  final _textEditingController = TextEditingController();
  final _translator = GoogleTranslator();
  var translatedText;

  double _volume = 0.5;
  double _rate = 0.7;
  double _pitch = 1;

  final _color1 = const Color.fromRGBO(227, 204, 174, 1);
  final _color2 = const Color.fromRGBO(184, 98, 27, 1);
  final _color3 = const Color.fromRGBO(38, 42, 86, 1);

  final String defaultLanguage = 'en-US';

  String? language;
  String? languageCode;
  List<String> languages = <String>[];
  List<String> languageCodes = <String>[];

  @override
  void initState() {
    super.initState();
    // _textEditingController.text = text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initLanguages();
    });
  }

  Future<void> initLanguages() async {
    /// populate lang code (i.e. en-US)
    languageCodes = await _textToSpeech.getLanguages();

    /// populate displayed language (i.e. English)
    final List<String>? displayLanguages =
        await _textToSpeech.getDisplayLanguages();
    if (displayLanguages == null) {
      return;
    }

    languages.clear();
    for (final dynamic lang in displayLanguages) {
      languages.add(lang as String);
    }

    final String? defaultLangCode = await _textToSpeech.getDefaultLanguage();
    if (defaultLangCode != null && languageCodes.contains(defaultLangCode)) {
      languageCode = defaultLangCode;
    } else {
      languageCode = defaultLanguage;
    }
    language = await _textToSpeech.getDisplayLanguageByCode(languageCode!);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, child) {
      return Scaffold(
        backgroundColor: themeNotifier.isDark ? null : _color1,
        appBar: AppBar(
            backgroundColor: _color2,
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
        body: SingleChildScrollView(
          child: Container(
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
                        color: themeNotifier.isDark ? _color1 : _color3),
                    cursorColor: _color2,
                    maxLines: 7,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _color2, width: 2.0),
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
                          color: themeNotifier.isDark ? _color1 : _color3),
                    ),
                    Expanded(
                      child: Slider(
                          inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
                          activeColor: _color2,
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
                          color: themeNotifier.isDark ? _color1 : _color3),
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
                          color: themeNotifier.isDark ? _color1 : _color3),
                    ),
                    Expanded(
                      child: Slider(
                          inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
                          activeColor: _color2,
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
                          color: themeNotifier.isDark ? _color1 : _color3),
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
                          color: themeNotifier.isDark ? _color1 : _color3),
                    ),
                    Expanded(
                      child: Slider(
                          inactiveColor: const Color.fromRGBO(184, 98, 27, 0.5),
                          activeColor: _color2,
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
                          color: themeNotifier.isDark ? _color1 : _color3),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Text(
                      'Language',
                      style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: themeNotifier.isDark ? _color1 : _color3),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    DropdownButton<String>(
                      value: language,
                      icon: Icon(Icons.arrow_downward,
                          color: themeNotifier.isDark ? _color1 : _color3),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(
                          color: themeNotifier.isDark ? _color1 : _color3),
                      underline: Container(
                        height: 2,
                        color: _color2,
                      ),
                      onChanged: (String? newValue) async {
                        languageCode = await _textToSpeech
                            .getLanguageCodeByName(newValue!);
                        // voice = await getVoiceByLang(languageCode!);
                        setState(() {
                          language = newValue;
                        });
                      },
                      items: languages
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton(
                        themeNotifier: themeNotifier,
                        onPressed: () async {
                          await _textToSpeech.setVolume(_volume);
                          await _textToSpeech.setRate(_rate);
                          if (languageCode != null) {
                            _textToSpeech.setLanguage(languageCode!);
                          }
                          await _textToSpeech.setPitch(_pitch);
                          await _textToSpeech
                              .speak(_textEditingController.text);
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
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildElevatedButton(
                        themeNotifier: themeNotifier,
                        onPressed: () async {
                          translatedText = '';
                          translatedText = await _translator.translate(
                              _textEditingController.text,
                              from: 'auto',
                              to: 'ar');
                          setState(() {});
                          // print("the translated text is : $translatedText");
                        },
                        buttonText: "Translate to Arabic"),
                    SizedBox(width: 10),
                    buildElevatedButton(
                        themeNotifier: themeNotifier,
                        onPressed: () async {
                          translatedText = '';
                          translatedText = await _translator.translate(
                              _textEditingController.text,
                              from: 'auto',
                              to: 'en');
                          setState(() {});
                          // print("the translated text is : $translatedText");
                        },
                        buttonText: "Translate to English"),
                  ],
                ),
                const SizedBox(height: 15),
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1,
                          color: themeNotifier.isDark ? _color1 : _color3)),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        translatedText != null ? translatedText.text : '',
                        textDirection: TextDirection.rtl,
                        style: GoogleFonts.cairo(
                            fontSize: 15,
                            color: themeNotifier.isDark ? _color1 : _color3),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget buildElevatedButton(
      {required ModelTheme themeNotifier,
      required VoidCallback onPressed,
      required String buttonText}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: themeNotifier.isDark ? _color1 : _color3),
      onPressed: onPressed,
      child: Text(
        buttonText,
        style: GoogleFonts.aBeeZee(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: themeNotifier.isDark
                ? const Color.fromRGBO(124, 61, 11, 1.0)
                : _color1),
      ),
    );
  }
}
