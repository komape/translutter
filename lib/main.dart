import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:share/share.dart';
import 'package:translutter/lang.dart';
import 'package:translutter/lang_reminder.dart';
import 'package:translutter/select_lang_view.dart';

import 'translator.dart';

void main() async {
  await dotenv.load();
  runApp(TranslutterApp());
}

class TranslutterApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Translutter',
      theme: ThemeData(
        primaryColor: Colors.black,
        appBarTheme: AppBarTheme(elevation: 0),
      ),
      home: HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Lang _sourceLang = LangRegister.sourceLangs[0];
  Lang _targetLang = LangRegister.targetLangs[0];
  TextEditingController _controller = new TextEditingController();
  String _translatedText = '';

  // ignore: unused_field
  late Future<void> _delayedTranslation;

  @override
  void initState() {
    super.initState();
    LangReminder.getSourceLang().then((Lang sourceLang) => setState(() {
          _sourceLang = sourceLang;
        }));
    LangReminder.getTargetLang().then((Lang targetLang) => setState(() {
          _targetLang = targetLang;
        }));
    _controller.addListener(translateDelayed);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void translateDelayed() {
    _delayedTranslation = Future<void>.delayed(Duration(seconds: 2), translate);
  }

  void selectLang(bool isSource) async {
    Lang? _selectedLang = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => SelectLangView(
            title: 'Select ${isSource ? 'Source' : 'Target'} Language',
            langs:
                isSource ? LangRegister.sourceLangs : LangRegister.targetLangs),
      ),
    );
    if (_selectedLang == null) return;
    String oldLangCode = isSource ? _sourceLang.code : _targetLang.code;
    if (isSource) {
      setState(() {
        _sourceLang = _selectedLang;
      });
      LangReminder.setSourceLang(_selectedLang);
    } else {
      setState(() {
        _targetLang = _selectedLang;
      });
      LangReminder.setTargetLang(_selectedLang);
    }
    if (oldLangCode != _selectedLang.code && _selectedLang.code != '')
      translate();
  }

  void switchLangs() {
    if (_sourceLang.code == '') return;
    Lang newSourceLang;
    if (_targetLang.code.length > 2) {
      final String targetCode = _targetLang.code.substring(0, 2);
      newSourceLang =
          LangRegister.sourceLangs.firstWhere((Lang l) => l.code == targetCode);
    } else {
      newSourceLang = _targetLang;
    }
    Lang newTargetLang = _sourceLang.code == 'EN'
        ? LangRegister.targetLangs.firstWhere((Lang l) => l.code == 'EN-GB')
        : _sourceLang;
    setState(() {
      _sourceLang = newSourceLang;
      _targetLang = newTargetLang;
    });
    if (_translatedText != '') {
      translate();
    }
    LangReminder.setSourceLang(newSourceLang);
    LangReminder.setTargetLang(newTargetLang);
  }

  void translate() async {
    try {
      TranslationResponse res = await Translator.translate(TranslationRequest(
          _sourceLang.code, _targetLang.code, _controller.text));
      Lang sourceLang = LangRegister.sourceLangs.firstWhere(
          (Lang l) => l.code == res.detectedSourceLangCode,
          orElse: () => _sourceLang);
      setState(() {
        _sourceLang = sourceLang;
        _translatedText = res.translatedText;
      });
      LangReminder.setSourceLang(sourceLang);
    } catch (err) {
      TranslationError transErr = err as TranslationError;
      print(transErr);
    }
  }

  void clear() {
    _controller.clear();
    setState(() {
      _translatedText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => selectLang(true),
              child: Text(
                _sourceLang.name,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .apply(color: Colors.white),
              ),
            ),
            IconButton(
              // can't switch languages if the source language must be detected first
              onPressed: _sourceLang.code == '' ? null : () => switchLangs(),
              icon: Icon(Icons.swap_horiz),
              disabledColor: Colors.white,
            ),
            TextButton(
                onPressed: () => selectLang(false),
                child: Text(
                  _targetLang.name,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .apply(color: Colors.white),
                )),
          ],
        ),
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            padding: const EdgeInsets.all(12),
            child: TextField(
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
              controller: _controller,
              textInputAction: TextInputAction.go,
              maxLength: 5000,
              onEditingComplete: translate,
              minLines: 5,
              maxLines: 12,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                fillColor: Colors.white,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintText: 'Enter or paste text here',
              ),
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade200,
            ),
            margin: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: _translatedText == ''
                      ? Text(
                          'Translated text will appear here',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey.shade700),
                        )
                      : Text(
                          _translatedText,
                          textAlign: TextAlign.start,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => Share.share(_translatedText),
                      icon: Icon(Icons.ios_share),
                    ),
                    IconButton(
                      onPressed: () => Clipboard.setData(
                          ClipboardData(text: _translatedText)),
                      icon: Icon(Icons.copy),
                    ),
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
